extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print('value : ', $Control/volume_slider.value)
	print('global volume : ', AudioManager.music_volume)


func _on_resume_pressed():
	Global.is_joystick = true
	Global.player_stop = false
	get_tree().paused = false  # Melanjutkan game
	hide()  # Sembunyikan pause menu
	$"../Pause".show()

func _on_main_menu_pressed():
	#Global.change_scene_to("res://Scenes/UIs/main_menu.tscn", transition_path)
	get_tree().paused = false
	AudioManager.bgm_player.stop()
	get_tree().change_scene_to_file("res://Scenes/UIs/main_menu.tscn")  # Pindah ke main menu
	
