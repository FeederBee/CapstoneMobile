extends Node2D

@onready var transition = $Transition/AnimationPlayer
@onready var player = $Y_sort/Karakter/Player
@onready var player_spawn_component: Node = $Components/PlayerSpawnComponent

var fasilkom_up
var fasilkom_mid
var fasilkom_down 

#Path
var transition_path = "fkip_area/Transition/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_map = Global.path_map.FKIP
	Global.auto_save_is = true
	AudioManager.play_bgm('entrance_area')
	transition.play('screen_fade_in')
	
	player_spawn_component.spawn_player()
	
	fasilkom_up = get_node("ControlLayer/ChangeMap_btn/fasilkom_atas_btn")
	fasilkom_mid = get_node("ControlLayer/ChangeMap_btn/fasilkom_bwh_btn")
	fasilkom_down = get_node("ControlLayer/ChangeMap_btn/fasilkom_mid_btn")
	
	fasilkom_up.visible = false
	fasilkom_mid.visible = false
	fasilkom_down.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_player():
	if SaveManager.load('current_map') == Global.current_map:
		var x = SaveManager.load("player_x_position") 
		var y = SaveManager.load("player_y_position") 
		player.global_position = Vector2(x, y)

	#if Global.spawn_position == Vector2.ZERO :
		#player_instance.global_position = Vector2(spawnx, spawny)
	#else :
		#player_instance.global_position = Global.spawn_position

#Area2D signal
func _on_to_fasilkom_up_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		fasilkom_up.visible = true

func _on_to_fasilkom_up_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		fasilkom_up.visible = false

func _on_to_fasilkom_mid_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		fasilkom_mid.visible = true

func _on_to_fasilkom_mid_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		fasilkom_mid.visible = false


func _on_to_fasilkom_bwh_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		fasilkom_down.visible = true


func _on_to_fasilkom_bwh_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		fasilkom_down.visible = false

#TouchButton signal
#Fasilkom
func _on_fasilkom_atas_btn_pressed() -> void:
	Global.change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2930, 984)
func _on_fasilkom_bwh_btn_pressed() -> void:
	Global.change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2930, 1594)
func _on_fasilkom_mid_btn_pressed() -> void:
	Global.change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2930, 2650)
