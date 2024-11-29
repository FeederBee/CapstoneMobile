extends Node


#Setting untuk Player
var player_stop:bool = false

# Variabel global untuk joystick
var is_joystick: bool = true

#Variabel untuk dialog
var is_dialog: bool = false

#var change_map: bool = false
#var previous_map : String = ""
var spawn_position : Vector2 = Vector2.ZERO
var blur: bool =false

var scene_transition: String 


func change_scene_to(path_scene: String, animation_node_path: String) -> void:
	var transition = get_tree().root.get_node_or_null(animation_node_path)
	if not transition:
		print("Error: Transition node not found at", animation_node_path)
		return

	# Memainkan animasi fade out
	transition.play("screen_fade_out")
	await transition.animation_finished
	
	# Ganti scene ke path yang ditentukan
	get_tree().change_scene_to_file(path_scene)
