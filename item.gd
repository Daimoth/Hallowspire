extends Sprite

var picked_up = false
var mouse_pos

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	if picked_up:
		#set coord to mouse position
		translate(get_viewport().get_mouse_position())
		print(position)

func _input(event):
	if event is InputEventMouseButton:
		#grab mouse position
		if event.pressed:
			#print(rectify_coords2((event.position)))
			mouse_pos = event.position
			_pressed()
	
func _pressed():
	if not picked_up:
		picked_up = true
	else:
		picked_up = false
	#print("Picked up: " + str(picked_up))
	#get mouse position

#Same as above, but 0,0 is the center of the window 
#rather than the center of the stage
func rectify_coords2(pos):
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	pos.x = pos.x - (screen_width / 2)
	pos.y = pos.y - (screen_height / 2)
	return pos