extends Node

#Array
#Dict untuk path map
var path_map = {
	'MAINMENU'	: "res://Scenes/UIs/MainMenu.tscn",
	'ENTRANCE'	: "res://Scenes/Map/EntranceAreaMap.tscn",
	'FASILKOM'	: "res://Scenes/Map/FasilkomAreaMap.tscn",
	'FKIP'		: "res://Scenes/Map/FKIPAreaMap.tscn",
	'FKG' 		: "res://Scenes/Map/FKGAreaMap.tscn",
	'FTP'		: "res://Scenes/Map/FTPAreaMap.tscn",
	'ENDINGCUTSCENE' : "res://Scenes/Cutscenes/EndingCutscene.tscn"
}

#Variable
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
var is_change_map: bool = false
var current_map:String = path_map.MAINMENU
var scene_transition: String 

#Save Variable
var auto_save_is:bool  #apakah sebuah scene bisa autosave atau tidak


func _process(delta: float) -> void:
	game_over()

#Function
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
func change_map(path_scene:String, animation_node_path: String) -> void:
	is_change_map = true
	var transition = get_tree().root.get_node_or_null(animation_node_path)
	if not transition:
		print("Error: Transition node not found at", animation_node_path)
		return

	# Memainkan animasi fade out
	transition.play("screen_fade_out")
	AudioManager.stop_bgm()
	await transition.animation_finished
	is_change_map = false
	# Ganti scene ke path yang ditentukan
	get_tree().change_scene_to_file(path_scene)

func cutscene_status(cutscene_name:String):
	var cutscene_data = SaveManager.load_data('cutscene')
	if cutscene_data == null:
		pass
	
	if cutscene_data != null and cutscene_data.has(cutscene_name):
		if cutscene_data[cutscene_name] == 'completed':
			return true
	
	return false
	

func get_all_quiz_completed():
	var quiz_progress = SaveManager.load_data("quiz_progress")
	var quiz_completed = 0
	if quiz_progress!=null:
		for map_name in quiz_progress.keys():
			var map_progress = quiz_progress[map_name]
			for quiz_name in map_progress.keys():
				if map_progress[quiz_name] == "completed":
					quiz_completed +=1
	return quiz_completed

func game_over():
	if get_all_quiz_completed() == 15:
		is_change_map = true
		AudioManager.stop_bgm()
		await get_tree().create_timer(0.3).timeout
		is_change_map = false
		# Ganti scene ke path yang ditentukan
		get_tree().change_scene_to_file("res://Scenes/Cutscenes/EndingCutscene.tscn")
	else :
		pass
