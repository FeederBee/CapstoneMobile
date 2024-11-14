extends Node2D

var fk_btn
var fkip_btn

func _ready() -> void:
	fk_btn = get_node("/root/FasilkomArea/CanvasButton/Button/fk_btn")
	fkip_btn = get_node("/root/FasilkomArea/CanvasButton/Button/fkip_btn")
	
	fk_btn.visible = false
	fkip_btn.visible = false
	
	#global_variable.change_map =/ t/rue
	#await get_tree().create_timer(0.3).timeout
	#global_variable.change_map = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_fk_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		fk_btn.visible = true
		#global_variable.change_map = true
		#get_tree().change_scene_to_file("res://Scenes/Map/kedokteran_area.tscn")

func _on_fk_body_exited(body: Node2D) -> void:
	fk_btn.visible = true


func _on_fk_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/kedokteran_area.tscn")


func _on_fkip_body_entered(body: Node2D) -> void:
	fkip_btn.visible = true


func _on_fkip_body_exited(body: Node2D) -> void:
	fkip_btn.visible = false


func _on_fkip_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Map/fkip_area.tscn")
