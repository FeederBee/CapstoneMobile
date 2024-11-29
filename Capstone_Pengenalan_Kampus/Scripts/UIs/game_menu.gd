extends Control

#$PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauseMenu.hide()  # Sembunyikan pause menu saat game dimulai

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> void:
	pass

# Fungsi untuk melanjutkan permainan
func _on_pause_pressed():
	Global.player_stop = true
	Global.is_joystick = false
	await get_tree().create_timer(0.1).timeout
	$PauseMenu.show()  # Menampilkan pause menu
	get_tree().paused = true  # Memberhentikan game
	$Pause.hide()

func _on_resume_pressed():
	Global.is_joystick = true
	Global.player_stop = false
	get_tree().paused = false  # Melanjutkan game
	$PauseMenu.hide()  # Sembunyikan pause menu
	$Pause.show()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UIs/main_menu.tscn")  # Pindah ke main menu

func _on_volume_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
