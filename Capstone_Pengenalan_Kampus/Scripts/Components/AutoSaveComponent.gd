extends Node

@onready var player = $"../../Y_sort/Karakter/Player"
@onready var auto_save_timer: Timer = $AutoSaveTimer
@onready var info_timer: Timer = $InfoTimer
@onready var info: Label = $CanvasLayer/info
@onready var failed: Label = $CanvasLayer/Failed

func _ready() -> void:
	print(player)
	info.hide()
	failed.hide()
	await get_tree().create_timer(2).timeout
	if Global.auto_save_is:
		auto_save_timer.start()

#
func _process(_delta: float) -> void:
	print("save timer", auto_save_timer.time_left)
	print("change_map is: ", Global.is_change_map)
	#if player:
		#print(player.position)
	if Global.is_change_map:
		auto_save_timer.stop()
		info_timer.stop()
	#pass

func _on_auto_save_timer_timeout() -> void:
	info.text = "Auto   Saving. . ."
	info.show()
	if player:
		SaveManager.save({
			"timestamp" : Time.get_datetime_string_from_system(), # Tambahkan timestamp sebagai identitas
			"player_x_position": player.position.x,
			"player_y_position": player.position.y,
			"player_stamina": player.stamina,
			"current_map": Global.current_map,
		})
	else:
		print("Player belum diinisialisasi!")
	info_timer.start()



func _on_info_timer_timeout() -> void:
	info.text = "Saving   Succed!"
	await get_tree().create_timer(3).timeout
	info.hide()
	auto_save_timer.start()
	

#
#func save_game():
	#info.show()
	#info_timer.start()
	#
	#var updates = {
		#'timestamp': Time.get_datetime_string_from_system(), # Tambahkan timestamp sebagai identitas
		#'x_position' : player.position.x, 
		#'y_position': player.position.y,
		#'current_map' : Global.current_map,
		#'music_volume' : AudioManager.music_volume
		#}
		#
	#for key in updates.keys():
		#PlayerData[key] = updates[key]
#
	#var jsonString = JSON.stringify(PlayerData,  "\t")
	#
	#var jsonFile = FileAccess.open("res://Save Game//savegame.json", FileAccess.WRITE)
	#jsonFile.store_line(jsonString)
	#jsonFile.close()
	#
	#print('saving')
#
#func load_game():
	#var jsonFile = FileAccess.open("res://Save Game//savegame.json", FileAccess.READ)
	#if not jsonFile: 
		## Error handling jika file tidak ditemukan
		#print("Save file not found!")
		#return null
	## Membaca file sebagai teks
	#var jsonString = jsonFile.get_as_text()
	#jsonFile.close()
	#
	## Parsing JSON menjadi Dictionary
	#var PlayerData = JSON.parse_string(jsonString)
	#return PlayerData
#
#func get_current_map():
	#return PlayerData.get('current_map')
	#
#func save_game():
	#var PlayerData = {
		#'x_position': player.position.x,
		#'y_position': player.position.y,
		#'timestamp': Time.get_datetime_string_from_system() # Tambahkan timestamp sebagai identitas
	#}
	#
	## Baca data lama dari file
	#var existing_data = []
	#if FileAccess.file_exists(save_path):
		#var json_file = FileAccess.open(save_path, FileAccess.READ)
		#var json_string = json_file.get_as_text()
		#json_file.close()
		#
		## Parse data jika valid
		##var json = JSON.new()
		#var parsed_data = JSON.parse_string(json_string)
		##if parsed_data.error == OK:
		#existing_data = parsed_data
	#
	#print('existingdata: ', existing_data)
	## Tambahkan data baru
	#existing_data.append(PlayerData)
	#print(PlayerData)
	#
	## Simpan data ke file
	#var json_string = JSON.stringify(existing_data, "\t") # "\t" untuk format lebih rapi
	#var json_file = FileAccess.open(save_path, FileAccess.WRITE)
	#json_file.store_string(json_string)
	#json_file.close()
	#
	#info.show()
#
#func load_game():
	## File path untuk load
	#var save_path = "res://Save Game/savegame.json"
	#
	#if not FileAccess.file_exists(save_path):
		#print("Save file not found!")
		#return
	#
	## Baca file JSON
	#var json_file = FileAccess.open(save_path, FileAccess.READ)
	#var json_string = json_file.get_as_text()
	#json_file.close()
	#
	## Parse data JSON
	#var json = JSON.new()
	#var parsed_data = json.parse_string(json_string)
	##if parsed_data != OK:
		##print("Failed to parse save file!")
		##return
	#
	##print(parsed_data.result)
	#
	## Ambil data terakhir dari array
	#var saved_games = parsed_data
	#if saved_games.size() > 0:
		#var last_save = saved_games[-1] # Data terakhir
		#player.position.x = last_save.x_position
		#player.position.y = last_save.y_position
	#else:
		#print("No save data found!")
#
