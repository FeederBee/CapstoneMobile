extends Node


#Player Variable
var player_stop:bool = false #player diizinkan bergerak atau tidak
var spawn_position : Vector2 = Vector2.ZERO #koordinat titik spawn player
#var blur: bool =false

var global_speed : float = 100  # Kecepatan default player
var buff_duration : float = 5.0  # Durasi buff dalam detik
var is_buffed : bool = false #player dibuff atau tidak

# Joystick Variable
var is_joystick: bool = true #aktif atau tidak

#Dialog Variable
var is_dialog: bool = false

#Scene Variable
var change_map: bool = false
var scene_transition: String 

#Player Function
func apply_speed_buff(new_speed: float, duration:float=0):
	if not is_buffed:
		global_speed = new_speed
		is_buffed = true
		await get_tree().create_timer(buff_duration+duration).timeout
		reset_speed()

func reset_speed():
	global_speed = 100
	is_buffed = false


#Scene Function
func change_scene_to(path_scene: String, animation_node_path: String) -> void:
	var transition = get_tree().root.get_node_or_null(animation_node_path)
	if not transition:
		print("Error: Transition node not found at", animation_node_path)
		return

	# Memainkan animasi fade out
	transition.play("screen_fade_out")
	AudioManager.stop_bgm()
	await transition.animation_finished
	
	# Ganti scene ke path yang ditentukan
	get_tree().change_scene_to_file(path_scene)
