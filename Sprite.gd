extends AnimatedSprite

var active_stage#tilemap
var moving 		#bool; whether the character is moving or not
var destination	#where the character will end up
var distance	#Distance between the starting position and destination
var move_speed	#if set to 1, player instantly teleports instead of running
var direction	#Vector2 representing which direction the character will move toward
var old_pos
var idle_frames = 41	#number of frames in the idle animation
var run_frames = 17		#number of frames in the run animation

#|||CHARACTER VARS|||
var char_name = "Daim"
var hp = 100
var cLvl = 1
var xp = 0
var char_inv = "inv"
var directions = 16
var current_dir = 0

var mouse_status = "released"

#to be serialized and saved to a file
var save_nodes

func _ready():
	#get the nodes to be serialized from the Persist group
	save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		save_game()
		pass
	#load_game()
	#print(get_save_dict())
	moving = false
	move_speed = 400
	set_process(true)
	#ensure your starting position and destination aren't null
	#make it wherever the player is for now
	if destination == null:
		destination = global_position
	if active_stage == null:
		active_stage = get_node("/root/stage_root/tilemap")
	play("idle")

func _process(delta):

	if moving:
		move_to(destination, delta)
	if global_position.distance_to(destination) <= 5:
		#print("Arrived!")
		destination = global_position
		moving = false
		play("idle")
	update()
	if animation == "idle":
		frame = (frame % idle_frames) + (idle_frames * current_dir)
	elif animation == "run":
		frame = (frame % run_frames) + (run_frames * current_dir)

func _unhandled_input(event):
	#print(event.as_text())
	if event is InputEventMouseButton:
		if event.pressed:
			current_dir = calc_dir((int(rad2deg(rectify_coords2(event.position).angle()) + 180)))
			set_destination(event.global_position)
			mouse_status = "clicked"
		else:
            mouse_status="released"
	if event is InputEventMouseMotion:
		if mouse_status == "clicked":
			mouse_status = "dragging"
		if mouse_status == "dragging":
			set_destination(event.global_position)
			current_dir = calc_dir((int(rad2deg(rectify_coords2(event.position).angle()) + 180)))

	#print(mouse_status)
		#Prints which tile was clicked
		#print("Tile clicked" + str(active_stage.world_to_map(rectify_coords1(event.position))))
		#Determines whether or not the tile is empty
		#print("Empty tile? ... " + str(active_stage.is_tile_empty_v(active_stage.world_to_map(rectify_coords1(event.position)))))

func calc_dir(angle):
	return (((angle + 11) * 16 / 360) + 4) % 16

#adjust the coords such that 0,0 is the center of the stage
func rectify_coords1(pos):
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	pos.x = pos.x - (screen_width / 2) + global_position.x
	pos.y = pos.y - (screen_height / 2) + global_position.y
	return pos

#Same as above, but 0,0 is the center of the window 
#rather than the center of the stage
func rectify_coords2(pos):
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	pos.x = pos.x - (screen_width / 2)
	pos.y = pos.y - (screen_height / 2)
	return pos


#Dest is meant to be a Vector2
func set_destination(dest):
	#print("setting destination!")
	#ensure the click's location is relative to game space, not the screen.
	destination = rectify_coords1(dest)
	moving = true
	play("run")

func move_to(dest, delta):
	old_pos = global_position
	distance = global_position.distance_to(destination)
	#print(distance)
	direction = destination - global_position
	direction = direction.normalized()
	#print(direction)
	#Trim distance until destination is on a valid tile
	global_translate(direction * move_speed * delta)
	if active_stage.get_cellv(active_stage.world_to_map(global_position)) == -1:
		#print("On empty cell")
		destination = global_position
		moving = false
		play("idle")
		global_position = old_pos

#|||BEGIN SAVE/LOAD FUNCS|||
#returns save data as a dictionary
func get_save_dict():
	var save_dict = {
		#"filename" : get_path(),
		#"parent" : get_parent().get_path(),
		"char_name" : char_name,
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"hp" : hp,
		"cLvl" : cLvl,
		"xp" : xp,
		"char_inv" : char_inv
    }
	return save_dict

# Note: This can be called from anywhere inside the tree.  This function is path independent.
# Go through everything in the persist category and ask them to return a dict of relevant variables
func save_game():
	print("Saving game!")
	var save_game = File.new()
	save_game.open("user://" + str(char_name) + ".save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("get_save_dict");
		print(node_data)
		save_game.store_line(to_json(node_data))
	save_game.close()

# Note: This can be called from anywhere inside the tree. This function is path independent.
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://" + str(char_name) + ".save"):
		print("No save data!")
		return
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
	# Load the file line by line and process that dictionary to restore the object it represents
	save_game.open("user://" + str(char_name) + ".save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		print(current_line)
		#print(get_path())
		#Create the object and add it to the tree and set its position.
		#var new_object = duplicate()
		#get_node(current_line["parent"]).add_child(new_object)
		position = Vector2(current_line["pos_x"], current_line["pos_y"])
		#Get the remaining variables.
		for i in current_line.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			set(i, current_line[i])
	save_game.close()