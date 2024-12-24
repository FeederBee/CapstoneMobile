extends Node2D

@onready var transition = $Transition/AnimationPlayer
@onready var player = $Y_sort/Karakter/Player
@onready var player_spawn_component: Node = $Components/PlayerSpawnComponent

var fasilkom_btn
var fkg_btn
var fkg2_btn

#path
var transition_path = 'FTPAreaMap/Transition/AnimationPlayer'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_map = Global.path_map.FTP
	Global.auto_save_is = true
	AudioManager.play_bgm('entrance_area')
	transition.play("screen_fade_in")
	
	player_spawn_component.spawn_player()
	
	fasilkom_btn = get_node("ControlLayer/ChangeMapBtn/FasilkomBtn")
	fkg_btn = get_node('ControlLayer/ChangeMapBtn/FKGBtn_R')
	fkg2_btn = get_node("ControlLayer/ChangeMapBtn/FKGBtn_L")
	
	fasilkom_btn.visible = false
	fkg_btn.visible = false
	fkg2_btn.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Area2D signal
func _on_to_fasilkom_body_entered(body: Node2D) -> void:
	fasilkom_btn.visible = true

func _on_to_fasilkom_body_exited(body: Node2D) -> void:
	fasilkom_btn.visible = false

func _on_to_fkg_body_entered(body: Node2D) -> void:
	fkg_btn.visible = true

func _on_to_fkg_body_exited(body: Node2D) -> void:
	fkg_btn.visible = false

func _on_to_fkg_2_body_entered(body: Node2D) -> void:
	fkg2_btn.visible = true

func _on_to_fkg_2_body_exited(body: Node2D) -> void:
	fkg2_btn.visible = false
	
#Button Touch Signal
