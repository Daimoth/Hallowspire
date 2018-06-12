extends TextureRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("inventory_toggle_hotkey"): 	
			#print ("inv toggle!")
			if visible == true:
				hide()
			else:
				show()
	elif event is InputEventMouseButton and event.pressed == true:
		#print("Inv clicked!")
		pass
