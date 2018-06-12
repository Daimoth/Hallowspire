extends Node2D

var raycast

func _ready():
	raycast = get_node("/root/stage_root/toon/bounds_detect")
	set_process(true)

func _process(delta):
	#draw_circle will only run once without this
	update()

func _draw():
	draw_circle(raycast.cast_to, 10, Color(0, 1, 0, .5))