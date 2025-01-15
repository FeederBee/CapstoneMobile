extends Control

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $BootAnimation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.transition_animation.play("screen_fade_in")
	animation_player.play('Boot')


func _on_animation_finished(_anim_name: StringName) -> void:
	#get_tree().change_scene_to_file("res://Scenes/UIs/MainMenu.tscn")
	Global.change_map(Global.path_map.MAINMENU)
