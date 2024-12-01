extends Node

var player

func enter_state():
	player._play_idle_animation()

func exit_state():
	pass

func _physics_process_state(delta: float):
	# Jika ada input gerakan, ganti state ke Walk
	var move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if move_vector != Vector2.ZERO:
		player.change_state(preload("res://Player/States/WalkState.gd"))
