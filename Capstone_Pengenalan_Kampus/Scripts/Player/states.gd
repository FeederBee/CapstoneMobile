#extends Node
extends Node

# Mengacu pada Player yang memiliki state ini
onready var player := get_parent().get_parent()

func enter_state():
	player._play_idle_animation()

func exit_state():
	pass

func _physics_process_state(delta: float):
	# Pindah ke Walk jika ada input gerakan
	var move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if move_vector != Vector2.ZERO:
		player.change_state("WalkState")
