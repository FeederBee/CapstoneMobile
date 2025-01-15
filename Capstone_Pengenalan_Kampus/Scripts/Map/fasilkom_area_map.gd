extends Node2D

#@onready var transition = $Transition/AnimationPlayer
@onready var player: CharacterBody2D = $Y_sort/Karakter/Player
@onready var player_spawn_component: Node = $Components/PlayerSpawnComponent

var ftp_btn
var fkip_btn_up
var fkip_btn_mid
var fkip_btn_down
var entrance_l_btn
var entrance_r_btn

#Path
#var transition_path = "FasilkomAreaMap/Transition/AnimationPlayer"

func _ready() -> void:
	#Data yang akan di save
	Global.current_map = Global.path_map.FASILKOM #Map saat ini di fasilkom
	Global.auto_save_is = true
	AudioManager.play_bgm('entrance_area')
	Global.transition_animation.play("screen_fade_in")
	
	player_spawn_component.spawn_player()
	

	ftp_btn = get_node("ControlLayer/ChangeMapBtn/FTPBtn")
	fkip_btn_up = get_node("ControlLayer/ChangeMapBtn/FKIPBtn_Up")
	fkip_btn_mid = get_node("ControlLayer/ChangeMapBtn/FKIPBtn_Mid")
	fkip_btn_down = get_node("ControlLayer/ChangeMapBtn/FKIPBtn_Down")
	entrance_l_btn = get_node("ControlLayer/ChangeMapBtn/EntranceBtn_L")
	entrance_r_btn = get_node("ControlLayer/ChangeMapBtn/EntranceBtn_R")
	
	ftp_btn.visible = false
	fkip_btn_up.visible = false
	fkip_btn_mid.visible = false
	fkip_btn_down.visible = false
	entrance_l_btn.visible = false
	entrance_r_btn.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _transition_fade_out():
	Global.transition_animation.play("screen_fade_in")
	await Global.transition_animation.animation_finished

#Area2D Signal
func _on_ftp_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_btn.visible = true
func _on_ftp_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_btn.visible = false

func _on_fkip_up_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fkip_btn_up.visible = true
func _on_fkip_up_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fkip_btn_up.visible = false
func _on_fkip_mid_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fkip_btn_mid.visible = true
func _on_fkip_mid_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fkip_btn_mid.visible = false
func _on_fkip_down_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fkip_btn_down.visible = true
func _on_fkip_down_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fkip_btn_down.visible = false

func _on_entrance_l_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		entrance_l_btn.visible = true
func _on_entrance_l_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		entrance_l_btn.visible = false
func _on_entrance_r_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		entrance_r_btn.visible = true
func _on_entrance_r_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		entrance_r_btn.visible = false
