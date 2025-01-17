extends Node2D

@onready var player = $Y_sort/Karakter/Player
@onready var AutoLoad = $Components/AutoLoadComponent
@onready var player_spawn_component = $Components/PlayerSpawnComponent

var fasilkom_l_btn
var fasilkom_r_btn

#Path scene 
var fasilkom = "res://Scenes/Map/FasilkomAreaMap.tscn"

#Transisi
@onready var transition = $Transition/AnimationPlayer

func _ready() -> void:
	#inisiasi Global Variable/function
	Global.current_map = Global.path_map.ENTRANCE
	Global.auto_save_is = true
	AudioManager.play_bgm('entrance_area')
	
	#if SaveManager.load_data('timestamp') == null:
		#$Transition.visible = false
	#else:
	Global.transition_animation.play("screen_fade_in")
	
	if Global.cutscene_status('Prolog'):
		player_spawn_component.spawn_player()
	
	
	fasilkom_l_btn = get_node("ControlLayer/ChangeMapBtn/FasilkomBtn_L")
	fasilkom_l_btn.visible = false
	
	fasilkom_r_btn =get_node("ControlLayer/ChangeMapBtn/FasilkomBtn_R")
	fasilkom_r_btn.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

#Area2D Signal
func _on_to_fasilkom_r_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_r_btn.visible = true

func _on_to_fasilkom_r_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_r_btn.visible = false

func _on_to_fasilkom_l_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_l_btn.visible = true

func _on_to_fasilkom_l_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_l_btn.visible = false
