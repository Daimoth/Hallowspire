extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _pressed():
	#Future: Check for save data. If there are no saves, straight to character creation
	get_tree().change_scene("char_creation.tscn")
	
func testfunc():
	pass
