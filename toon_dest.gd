extends Label

# class member variables go here, for example:
var toon

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	toon = get_node("/root/stage_root/toon")
	set_process(true)
	pass

func _process(delta):
	text = "Char destination:" + str(toon.destination)