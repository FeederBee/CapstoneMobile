extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print('max value : ', $Control/music_volume.max_volume)
	#print('max value : ', $Control/sfx_volume.max_volume)
	#print('max value : ', $Control/music_volume.min_volume)
	#print('max value : ', $Control/sfx_volume.min_volume)
	print('value : ', $Control/music_volume.value)
	print('value : ', $Control/sfx_volume.value)
	
	#print('global volume : ', AudioManager.music_volume)
	pass


func _on_resume_pressed():
	AudioManager.play_sfx("button_click")
	Global.is_joystick = true
	Global.player_stop = false
	get_tree().paused = false  # Melanjutkan game
	hide()  # Sembunyikan pause menu
	$"../Pause".show()

func _on_main_menu_pressed():
	AudioManager.play_sfx("button_click")
	#Global.change_scene_to("res://Scenes/UIs/main_menu.tscn", transition_path)
	get_tree().paused = false
	AudioManager.bgm_player.stop()
	get_tree().change_scene_to_file("res://Scenes/UIs/main_menu.tscn")  # Pindah ke main menu
	
