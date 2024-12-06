extends Control

var play 
var loadgame
var setting 

#Path Scene
var Entrance_map = "res://Scenes/Map/entrance_area.tscn"

#transisi
var transition_path = "MainMenu/AnimationPlayer"
@onready var transition = $AnimationPlayer
@onready var setting_menu: Control =$CanvasLayer/setting_menu
@onready var button_component: Control = $ButtonComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#MapManager.preload_maps()
	setting_menu.hide()
	transition.play("screen_fade_in")
	AudioManager.play_bgm("main_menu")
	
	play = false
	loadgame = false
	setting = false
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	play = true
	Global.is_joystick = true
	Global.player_stop = false
	Global.spawn_position = Vector2.ZERO
	Global.change_scene_to(Entrance_map, transition_path)

func _on_load_pressed() -> void:
	Global.is_joystick = true
	Global.player_stop = false


func _on_setting_pressed() -> void:
	button_component.hide()
	setting_menu.show()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_released() -> void:
	pass # Replace with function body.

func _on_load_released() -> void:
	pass # Replace with function body.

func _on_setting_released() -> void:
	pass

func _on_quit_released() -> void:
	pass # Replace with function body.

#Animasi screen
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if play: 
		pass
	else : 
		pass
