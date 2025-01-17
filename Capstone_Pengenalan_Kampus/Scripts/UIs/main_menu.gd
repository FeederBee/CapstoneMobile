extends Control

#@onready var transition = $AnimationPlayer
@onready var setting_menu: Control =$CanvasLayer/SettingMenu
@onready var button: Control = $Button
@onready var lanjut_btn: TouchScreenButton = $Button/Lanjut
@onready var start_btn: TouchScreenButton = $Button/Start
@onready var credit: TextureRect = $Credits/CanvasLayer/Control/Credit
@onready var credit_button: TouchScreenButton = $Button/CreditButton

#Path Scene
var Entrance_map = "res://Scenes/Map/EntranceAreaMap.tscn"

#transisi
#var transition_path = "MainMenu/AnimationPlayer"
@onready var player_data = SaveManager.load_data("current_map")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setting_menu.hide()
	credit.hide()
	if player_data != null:
		lanjut_btn.show()
		start_btn.hide()
	else:
		start_btn.show()
		lanjut_btn.hide()

	#Global
	Global.current_map = Global.path_map.MAINMENU
	Global.auto_save_is = false
	
	Global.transition_animation.play("screen_fade_in")
	AudioManager.play_bgm("main_menu")	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_data != null:
		lanjut_btn.show()
		start_btn.hide()
	else:
		start_btn.show()
		lanjut_btn.hide()
		#pass

func _on_play_pressed() -> void:
	AudioManager.play_sfx("button_click")
	Global.save_time('start')
	Global.is_joystick = true
	Global.player_stop = false
	Global.change_map(Global.path_map.ENTRANCE)

func _on_load_pressed() -> void:
	AudioManager.play_sfx("button_click")
	Global.is_joystick = true
	Global.player_stop = false
	if player_data:
		Global.change_map(player_data)
	else : 
		print("Load Failed")

func _on_setting_pressed() -> void:
	AudioManager.play_sfx("button_click")
	button.hide()
	credit_button.hide()
	setting_menu.show()

func _on_quit_pressed() -> void:
	AudioManager.play_sfx("button_click")
	get_tree().quit()

func _on_lanjut_pressed() -> void:
	AudioManager.play_sfx("button_click")
	Global.is_joystick = true
	Global.player_stop = false
	Global.change_map(player_data)


func _on_credit_button_pressed() -> void:
	AudioManager.play_sfx("button_click")
	button.hide()
	credit.show()
	credit_button.hide()


func _on_close_button_pressed() -> void:
	AudioManager.play_sfx("button_click")
	button.show()
	credit.hide()
	credit_button.show()
