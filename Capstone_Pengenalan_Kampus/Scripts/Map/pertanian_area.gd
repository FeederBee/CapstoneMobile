extends Node2D

@onready var transition = $Transition/AnimationPlayer

var fasilkom_btn
var fkg_btn
var fkg2_btn

#path
var transition_path = 'ftp_area/Transition/AnimationPlayer'
var fasilkom_path = 'res://Scenes/Map/fasilkom_area.tscn'
var fkg_path = 'res://Scenes/Map/fkg_area.tscn'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("screen_fade_in")
	
	var player_instance = get_node("Y_sort/Karakter/Player")	
	if Global.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(1446, 3097)
	else :
		player_instance.global_position = Global.spawn_position
	
	fasilkom_btn = get_node("ControlLayer/ChangeMap_btn/fasilkom_btn")
	fkg_btn = get_node('ControlLayer/ChangeMap_btn/fkg_btn')
	fkg2_btn = get_node("ControlLayer/ChangeMap_btn/fkg2_btn")
	
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

func _on_fasilkom_btn_pressed() -> void:
	Global.change_scene_to(fasilkom_path, transition_path)
	Global.spawn_position = Vector2(10, 1508)

func _on_fkg_btn_pressed() -> void:
	Global.change_scene_to(fkg_path, transition_path)
	Global.spawn_position = Vector2(2634, 58)

func _on_fkg_2_btn_pressed() -> void:
	Global.change_scene_to(fkg_path, transition_path)
	Global.spawn_position = Vector2(1497, 58)
