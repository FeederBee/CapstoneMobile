extends Node2D

@export var spawnx: float = 2544
@export var spawny: float = 1219

var fasilkom_up
var fasilkom_mid
var fasilkom_down 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = get_node("Y_sort/Karakter/Player")	
	if global_variable.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(spawnx, spawny)
	else :
		player_instance.global_position = global_variable.spawn_position
	
	fasilkom_up = get_node("CanvasLayer/fasilkom_atas_btn")
	fasilkom_mid = get_node("CanvasLayer/fasilkom_bwh_btn")
	fasilkom_down = get_node("CanvasLayer/fasilkom_mid_btn")
	
	fasilkom_up.visible = false
	fasilkom_mid.visible = false
	fasilkom_down.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

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
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(2930, 984)
func _on_fasilkom_bwh_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(2930, 1594)
func _on_fasilkom_mid_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(2930, 2650)
