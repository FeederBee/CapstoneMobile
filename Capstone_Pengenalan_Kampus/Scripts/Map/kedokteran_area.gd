extends Node2D

@onready var player = $Y_sort/Player

var fasilkom_btn
var ftp_btn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_instance = get_node("Y_sort/Karakter/Player")	
	if global_variable.spawn_position == Vector2.ZERO :
		player_instance.global_position = Vector2(2558, 1032)
	else :
		player_instance.global_position = global_variable.spawn_position
	
	fasilkom_btn = get_node("ChangeMap_btn/fasilkom_button")
	fasilkom_btn.visible = false
	
	ftp_btn = get_node("ChangeMap_btn/ftp_btn")
	ftp_btn.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Area2D Signal
func _on_to_fasilkom_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_btn.visible = true
func _on_to_fasilkom_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		fasilkom_btn.visible = false
		

func _on_to_ftp_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_btn.visible = true
func _on_to_ftp_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		ftp_btn.visible = false


#Button Touch Signal
func _on_fasilkom_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fasilkom_area.tscn")
	global_variable.spawn_position = Vector2(89,2636)

func _on_ftp_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/ftp_area.tscn")
	global_variable.spawn_position = Vector2(1432, 3160)
