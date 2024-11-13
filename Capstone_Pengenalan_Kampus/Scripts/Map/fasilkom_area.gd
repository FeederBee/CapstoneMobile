extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_variable.change_map = true
	await get_tree().create_timer(0.3).timeout
	global_variable.change_map = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ganti_area_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		global_variable.change_map = true
		get_tree().change_scene_to_file("res://Scenes/Map/fkip_area.tscn")



func _on_fk_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		get_tree().change_scene_to_file("res://Scenes/Map/kedokteran_area.tscn")
		global_variable.change_map = true


func _on_fk_body_exited(body: Node2D) -> void:
	global_variable.change_map = false
