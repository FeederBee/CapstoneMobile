extends Node2D

var fk_btn
var fkip_btn_up
var fkip_btn_mid
var fkip_btn_down
var entrance_l_btn
var entrance_r_btn

func _ready() -> void:
	
	var player_instance = get_node("Y_sort/Player")	
	if global_variable.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(2267, 1489)
	else :
		player_instance.global_position = global_variable.spawn_position

	fk_btn = get_node("ChangeMap_btn/fk_btn")
	fkip_btn_up = get_node("ChangeMap_btn/fkip_btn_up")
	fkip_btn_mid = get_node("ChangeMap_btn/fkip_btn_mid")
	fkip_btn_down = get_node("ChangeMap_btn/fkip_btn_down")
	entrance_l_btn = get_node("ChangeMap_btn/entrance_l_btn")
	entrance_r_btn = get_node("ChangeMap_btn/entrance_r_btn")
	
	fk_btn.visible = false
	fkip_btn_up.visible = false
	fkip_btn_mid.visible = false
	fkip_btn_down.visible = false
	entrance_l_btn.visible = false
	entrance_r_btn.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Area2D Signal
func _on_fk_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fk_btn.visible = true
func _on_fk_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fk_btn.visible = false

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
func _on_fk_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/kedokteran_area.tscn")
	global_variable.spawn_position = Vector2(2568, 57)

func _on_fkip_btn_up_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fkip_area.tscn")
	global_variable.spawn_position = Vector2(56, 904)
func _on_fkip_btn_mid_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fkip_area.tscn")
	global_variable.spawn_position = Vector2(49, 1497)
func _on_fkip_btn_down_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fkip_area.tscn")
	global_variable.spawn_position = Vector2(49, 2822)

func _on_entrance_l_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/entrance_area.tscn")
	global_variable.spawn_position = Vector2(2297, 26)
func _on_entrance_r_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/entrance_area.tscn")
	global_variable.spawn_position = Vector2(1498, 26)
