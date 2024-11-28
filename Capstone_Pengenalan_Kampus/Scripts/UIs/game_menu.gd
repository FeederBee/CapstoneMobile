extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> void:
	pass


func _on_pause_pressed() -> void:
	Global.is_joystick = false
	get_tree().change_scene_to_file("res://Scenes/UIs/main_menu.tscn")
	#Global.change_scene_to("res://Scenes/UIs/main_menu.tscn", transition_path)
