extends Control

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $BootAnimation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play('Boot')


func _on_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/UIs/MainMenu.tscn")
