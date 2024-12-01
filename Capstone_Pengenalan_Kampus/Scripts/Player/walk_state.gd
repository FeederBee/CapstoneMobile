extends Node

onready var player := get_parent().get_parent()

func enter_state():
	pass

func exit_state():
	player.last_direction = player.move_vector.normalized()

func _physics_process_state(delta: float):
	player.move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if player.move_vector != Vector2.ZERO:
		player.velocity = player.move_vector * player.speed
		player.move_and_slide()
		player._play_walk_animation(player.move_vector)
	else:
		player.change_state("IdleState")
