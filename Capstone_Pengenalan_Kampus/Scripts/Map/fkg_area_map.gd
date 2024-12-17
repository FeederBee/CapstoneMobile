extends Node2D

@onready var player = $Y_sort/Karakter/Player
@onready var transition = $Transition/AnimationPlayer
@onready var player_spawn_component = $Components/PlayerSpawnComponent

var ftp_r_btn
var ftp_l_btn

#Path variable
var transition_path = "FKGAreaMap/Transition/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_map = Global.path_map.FKG
	Global.auto_save_is = true
	AudioManager.play_bgm('entrance_area')
	transition.play("screen_fade_in")
	
	player_spawn_component.spawn_player()
	
	ftp_r_btn = get_node("ControlLayer/ChangeMapBtn/FTPBtn_R")
	ftp_r_btn.visible = false
	
	ftp_l_btn = get_node("ControlLayer/ChangeMapBtn/FTPBtn_L")
	ftp_l_btn.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Area2D Signal
func _on_ftp_r_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_r_btn.visible = true
func _on_ftp_r_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_r_btn.visible = false
		

func _on_ftp_l_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_l_btn.visible = true
func _on_ftp_l_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_l_btn.visible = false


#Button Touch Signal
func _on_ftp_r_button_pressed() -> void:
	Global.change_map(Global.path_map.FTP, transition_path)
	Global.spawn_position = Vector2(3864, 3605)

func _on_ftp_l_btn_pressed() -> void:
	Global.change_map(Global.path_map.FTP, transition_path)
	Global.spawn_position = Vector2(1766, 3604)


func _on_ftp_l__body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_ftp_l__body_exited(body: Node2D) -> void:
	pass # Replace with function body.
