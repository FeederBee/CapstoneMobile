#extends Node
#
#@onready var player = $Player
#
#func save_game():
	#var PlayerData = {
		#'x_position' : player.position.x,
		#'y_position': player.position.y,
		#'timestamp': Time.get_datetime_string_from_system() # Tambahkan timestamp sebagai identitas
	#}
	#
	#var jsonString = JSON.stringify(PlayerData)
	#
	#var jsonFile = FileAccess.open("res://Save Game//savegame.json", FileAccess.WRITE)
	#jsonFile.store_line(jsonString)
	#jsonFile.close()
#
#func load_game():
	#var jsonFile = FileAccess.open("res://Save Game//savegame.json", FileAccess.READ)
	#var jsonString = jsonFile.get_as_text()
	#jsonFile.close()
	#
	#var PlayerData = JSON.parse_string(jsonString)
	#
	#player.position.x = PlayerData.x_position
	#player.position.y = PlayerData.y_position

extends Node

@onready var player = $Player
var save_path = "res://Save Game/savegame.json"	# File path untuk save

func save_game():
	var PlayerData = {
		'x_position': player.position.x,
		'y_position': player.position.y,
		'timestamp': Time.get_datetime_string_from_system() # Tambahkan timestamp sebagai identitas
	}
	
	# Baca data lama dari file
	var existing_data = []
	if FileAccess.file_exists(save_path):
		var json_file = FileAccess.open(save_path, FileAccess.READ)
		var json_string = json_file.get_as_text()
		json_file.close()
		
		# Parse data jika valid
		#var json = JSON.new()
		var parsed_data = JSON.parse_string(json_string)
		#if parsed_data.error == OK:
		existing_data = parsed_data
	
	print('existingdata: ', existing_data)
	# Tambahkan data baru
	existing_data.append(PlayerData)
	print(PlayerData)
	
	# Simpan data ke file
	var json_string = JSON.stringify(existing_data, "\t") # "\t" untuk format lebih rapi
	var json_file = FileAccess.open(save_path, FileAccess.WRITE)
	json_file.store_string(json_string)
	json_file.close()

func load_game():
	# File path untuk load
	var save_path = "res://Save Game/savegame.json"
	
	if not FileAccess.file_exists(save_path):
		print("Save file not found!")
		return
	
	# Baca file JSON
	var json_file = FileAccess.open(save_path, FileAccess.READ)
	var json_string = json_file.get_as_text()
	json_file.close()
	
	# Parse data JSON
	var json = JSON.new()
	var parsed_data = json.parse_string(json_string)
	#if parsed_data != OK:
		#print("Failed to parse save file!")
		#return
	
	#print(parsed_data.result)
	
	# Ambil data terakhir dari array
	var saved_games = parsed_data
	if saved_games.size() > 0:
		var last_save = saved_games[-1] # Data terakhir
		player.position.x = last_save.x_position
		player.position.y = last_save.y_position
	else:
		print("No save data found!")


func _on_load_pressed() -> void:
	load_game()


func _on_save_pressed() -> void:
	save_game()
