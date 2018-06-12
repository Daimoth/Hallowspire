extends Button

var toon

func _ready():
	toon = get_node("/root/stage_root/toon")
	pass

func _pressed():
	toon.save_game()
	get_tree().change_scene("menu.tscn")
