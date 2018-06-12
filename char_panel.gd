extends TextureRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("char_sheet_toggle_hotkey"): 	
			#print ("char toggle!")
			if visible == true:
				hide()
			else:
				show()
