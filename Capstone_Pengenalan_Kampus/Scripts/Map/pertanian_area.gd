extends Node2D

var fasilkom_btn
var fk_btn
var fk2_btn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = get_node("Y_sort/Karakter/Player")	
	if global_variable.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(1446, 3097)
	else :
		player_instance.global_position = global_variable.spawn_position
	
	fasilkom_btn = get_node("ChangeMap_btn/fasilkom_btn")
	fk_btn = get_node('ChangeMap_btn/fk_btn')
	fk2_btn = get_node("ChangeMap_btn/fk2_btn")
	
	fasilkom_btn.visible = false
	fk_btn.visible = false
	fk2_btn.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Area2D signal
func _on_to_fasilkom_body_entered(body: Node2D) -> void:
	fasilkom_btn.visible = true

func _on_to_fasilkom_body_exited(body: Node2D) -> void:
	fasilkom_btn.visible = false


func _on_to_fk_body_entered(body: Node2D) -> void:
	fk_btn.visible = true

func _on_to_fk_body_exited(body: Node2D) -> void:
	fk_btn.visible = false

func _on_to_fk_2_body_entered(body: Node2D) -> void:
	fk2_btn.visible = true

func _on_to_fk_2_body_exited(body: Node2D) -> void:
	fk2_btn.visible = false
	
#Button Touch Signal

func _on_fasilkom_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(276, 1517)

func _on_fk_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/kedokteran_area.tscn")
	global_variable.spawn_position = Vector2(2563, 64)

func _on_fk_2_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/kedokteran_area.tscn")
	global_variable.spawn_position = Vector2(1593, 78)
