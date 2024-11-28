extends Node2D

@onready var transition = $Transition/AnimationPlayer

@export var spawnx: float = 2544
@export var spawny: float = 1219

var ftp_btn
var fkip_btn_up
var fkip_btn_mid
var fkip_btn_down
var entrance_l_btn
var entrance_r_btn

#Path
var transition_path = "fasilkom_area/Transition/AnimationPlayer"
var ftp_path = "res://Scenes/Map/ftp_area.tscn"
var fkip_path = "res://Scenes/Map/fkip_area.tscn"
var entrance_path = "res://Scenes/Map/entrance_area.tscn"

func _ready() -> void:
	transition.play("screen_fade_in")
	
	var player_instance = get_node("Y_sort/Karakter/Player")	
	if Global.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(spawnx, spawny)
	else :
		player_instance.global_position = Global.spawn_position

	ftp_btn = get_node("ControlLayer/ChangeMap_btn/ftp_btn")
	fkip_btn_up = get_node("ControlLayer/ChangeMap_btn/fkip_btn_up")
	fkip_btn_mid = get_node("ControlLayer/ChangeMap_btn/fkip_btn_mid")
	fkip_btn_down = get_node("ControlLayer/ChangeMap_btn/fkip_btn_down")
	entrance_l_btn = get_node("ControlLayer/ChangeMap_btn/entrance_l_btn")
	entrance_r_btn = get_node("ControlLayer/ChangeMap_btn/entrance_r_btn")
	
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
	transition.play("screen_fade_out")
	await transition.animation_finished

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


#Touch Button Signal
func _on_ftp_button_pressed() -> void:
	Global.change_scene_to(ftp_path, transition_path)
	Global.spawn_position = Vector2(4149, 2649)

#FKIP
func _on_fkip_btn_up_pressed() -> void:
	Global.change_scene_to(fkip_path, transition_path)
	Global.spawn_position = Vector2(121, 1161)
func _on_fkip_btn_mid_pressed() -> void:
	Global.change_scene_to(fkip_path, transition_path)
	Global.spawn_position = Vector2(117, 2058)
func _on_fkip_btn_down_pressed() -> void:
	Global.change_scene_to(fkip_path, transition_path)
	Global.spawn_position = Vector2(118, 3355)

func _on_entrance_l_btn_pressed() -> void:
	Global.change_scene_to(entrance_path, transition_path)
	Global.spawn_position = Vector2(1097, 50)
func _on_entrance_r_btn_pressed() -> void:
	Global.change_scene_to(entrance_path, transition_path)
	Global.spawn_position = Vector2(2921, 51)
