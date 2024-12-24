extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(SaveManager.load_data('music_volume'))


func _on_resume_pressed():
	AudioManager.play_sfx("button_click")
	Global.is_joystick = true
	Global.player_stop = false
	get_tree().paused = false  # Melanjutkan game
	hide()  # Sembunyikan pause menu
	$"../Pause".show()

func _on_main_menu_pressed():
	AudioManager.play_sfx("button_click")
	get_tree().paused = false
	AudioManager.bgm_player.stop()
	get_tree().change_scene_to_file("res://Scenes/UIs/MainMenu.tscn")  # Pindah ke main menu
	
