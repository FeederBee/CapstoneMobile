extends Node2D

var fasilkom_l_btn
var fasilkom_r_btn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = get_node("Y_sort/Player")	
	if global_variable.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(2012, 139)
	else :
		player_instance.global_position = global_variable.spawn_position
	
	fasilkom_l_btn = get_node("ChangeMap_btn/fasilkom_l_btn")
	fasilkom_l_btn.visible = false
	
	fasilkom_r_btn =get_node("ChangeMap_btn/fasilkom_r_btn")
	fasilkom_r_btn.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Area2D Signal
func _on_to_fasilkom_r_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_l_btn.visible = true

func _on_to_fasilkom_r_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_l_btn.visible = false

func _on_to_fasilkom_l_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_r_btn.visible = true

func _on_to_fasilkom_l_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_r_btn.visible = false
	
#Button Touch Signal
func _on_fasilkom_l_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(2215, 2646)

func _on_fasilkom_r_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(1685, 2644)
