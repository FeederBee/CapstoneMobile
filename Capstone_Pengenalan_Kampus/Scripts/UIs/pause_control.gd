extends Control

@onready var pause_btn: TouchScreenButton = $Pause


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauseMenu.hide()  # Sembunyikan pause menu saat game dimulai
	Dialogic.signal_event.connect(_on_dialogic_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.is_dialog:
		pause_btn.hide()
	else:
		await get_tree().create_timer(0.5).timeout
		pause_btn.show()
# Fungsi untuk melanjutkan permainan

func _on_pause_pressed():
	AudioManager.play_sfx("button_click")
	Global.player_stop = true
	Global.is_joystick = false
	await get_tree().create_timer(0.2).timeout
	$PauseMenu.show()  # Menampilkan pause menu
	get_tree().paused = true  # Memberhentikan game
	$Pause.hide()
	
func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		pause_btn.hide()
