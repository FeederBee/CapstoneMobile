extends Node

@onready var transition_animation: AnimationPlayer = $Transition/AnimationPlayer

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
var is_game_done:bool = false

#Save Variable
var auto_save_is:bool  #apakah sebuah scene bisa autosave atau tidak

# Variabel untuk menghemat process
var last_check_time : float = 0.0
var check_interval : float = 1.0 # Waktu jeda antar pengecekan dalam detik

func _process(delta: float) -> void:
	# Periksa jika cukup waktu telah berlalu sejak pengecekan terakhir
	if Time.get_ticks_msec() / 1000.0 - last_check_time >= check_interval:
		last_check_time = Time.get_ticks_msec() / 1000.0
		#story_done()
		pass
		

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
func change_map(path_scene:String) -> void:
	#$Transition/ColorRect.hide()
	is_change_map = true
	#var transition =
	if not transition_animation:
		print("Error: Transition node not found at", transition_animation)
		return

	# Memainkan animasi fade out
	transition_animation.play("screen_fade_out")
	AudioManager.stop_bgm()
	await transition_animation.animation_finished
	#$Transition/ColorRect.hide()
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
	

# Fungsi untuk menghitung semua kuis yang telah selesai
func get_all_quiz_completed() -> int :
	# Memuat data progres kuis dari SaveManager
	var quiz_progress = SaveManager.load_data("quiz_progress")
	var quiz_completed = 0
	
	# Pastikan data kuis ada sebelum melanjutkan
	if quiz_progress != null:
		# Iterasi melalui setiap map untuk menghitung kuis yang selesai
		for map_name in quiz_progress.keys():
			var map_progress = quiz_progress[map_name]
			# Pastikan map_progress adalah dictionary
			if map_progress is Dictionary:
				for quiz_name in map_progress.keys():
					# Periksa apakah status kuis adalah "completed"
					if map_progress[quiz_name] == "completed":
						quiz_completed += 1
			else:
				printerr("Invalid data format for map_progress: ", map_name)
	else:
		printerr("Quiz progress data is null or corrupted.")
		
	return quiz_completed

# Fungsi untuk mengecek apakah cerita sudah selesai
#func story_done():
	#if !is_game_done:	
		#if get_all_quiz_completed() >= 16 and !is_new_game:
			#is_game_done = true
		#return

	
	#if "path_map" in self and path_map.ENDINGCUTSCENE:
		#change_map(path_map.ENDINGCUTSCENE)
		#
	#is_game_done = false

func new_game():
	#SaveManager.clear_data()  # Reset semua data game
	change_map(path_map.STARTING_AREA)  # Mulai dari area awal
