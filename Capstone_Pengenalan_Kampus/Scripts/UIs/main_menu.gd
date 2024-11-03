extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_load_pressed() -> void:
	#GameManager.load_game()  # Memuat game dari posisi terakhir
	pass


func _on_setting_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_released() -> void:
	pass # Replace with function body.

func _on_load_released() -> void:
	pass # Replace with function body.

func _on_setting_released() -> void:
	pass # Replace with function body.

func _on_quit_released() -> void:
	pass # Replace with function body.
