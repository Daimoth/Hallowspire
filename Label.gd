extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass

func _process(delta):
	text = str(get_node("/root/stage_root/toon/Camera2D").global_position)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

