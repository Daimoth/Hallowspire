extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var audio_manager

func _ready():
	audio_manager = get_node("/root/logic_root/audio_manager/AudioStreamPlayer")

func _pressed():
	#change to boneyard soundtrack
	get_tree().change_scene("stage_prototype.tscn")
