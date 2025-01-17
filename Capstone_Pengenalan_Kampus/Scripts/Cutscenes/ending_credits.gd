extends Node2D

@onready var animation_player: AnimationPlayer = $ScreenAnimation/AnimationPlayer
@onready var credits_animation: AnimationPlayer = $CanvasLayer/CreditsAnimation
@onready var bg_fade_out: ColorRect = $CanvasLayer/BgFadeOut


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	bg_fade_out.self_modulate = 0
	Global.transition_animation.play("screen_fade_in")
	animation_player.play("fade_in")
	await animation_player.animation_finished
	credits_animation.play("credit")
	await credits_animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/UIs/MainMenu.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
