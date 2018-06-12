extends Node2D

var raycast

func _ready():
	raycast = get_node("/root/stage_root/toon/bounds_detect")
	set_process(true)

func _process(delta):
	#draw_circle will only run once without this
	update()

func _draw():
	#draws where the raycast is cast to
	draw_circle(raycast.cast_to, 10, Color(1, 0, 0, .5))