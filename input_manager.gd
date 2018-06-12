extends Node

var toon1
var inv_panel
var char_panel
var input_delay

func _ready():
	self.set_process(true)
	input_delay = 0

func _process(delta):
	#input_delay += 1
	#print (input_delay)
	pass

func _input(event):
	pass
	#If the user is ingame (i.e. not in the main menu, char select, etc.)
	#if get_tree().current_scene.name.match("stage_root"):
		#!This event is firing twice, moving characger too much
		#... and the user clicks the mouse
		#if event is InputEventMouseButton and event.pressed == true:
			#grab the player character
			#if toon1 == null:
				#toon1 = get_node("/root/stage_root/toon")
			#Move character and camera to that new location
			#if toon1 != null:
				#toon1.global_translate(rectify_coords(get_viewport().get_mouse_position(), toon1))				

		#... and the user presses a key
		#if event is InputEventKey:
			#if event.is_action_pressed("inventory_toggle_hotkey"): 	
				#print (event.action)
				#if inv_panel == null:
					#inv_panel = get_node("/root/stage_root/inv_panel")
				#if inv_panel.visible == true: 
					#inv_panel.hide()
					#print("inv off")
				#else: 
					#inv_panel.show()
			#if event.is_action_pressed("char_sheet_toggle_hotkey"): 
				#print("char sheet toggle!")
			
#get sprite location coordinates jiving with click location coordinates\
#Basically, treat the center of the screen like 0,0 
#x - (screewidth/2), y -(screenheight/2)
func rectify_coords(pos, toon):
	var screen_width = toon.get_viewport_rect().size.x
	var screen_height = toon.get_viewport_rect().size.y
	pos.x = pos.x - (screen_width / 2)
	pos.y = pos.y - (screen_height / 2)
	return pos
