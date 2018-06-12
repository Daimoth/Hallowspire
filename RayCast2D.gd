extends RayCast2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	enabled = true

func _process(delta):
	#the following line of code is working, but destination isn't updating often enough
	#destination is only updating on click
	cast_to = get_node("/root/stage_root/toon").destination #"/root/stage_root/tilemap"
	#print("cast_to: " + str(cast_to))
	#force_raycast_update()

