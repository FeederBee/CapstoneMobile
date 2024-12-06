extends Node

# Path untuk save file
const SAVE_FILE_PATH = "user://save_data.json"

# Data game yang akan disimpan
var save_data: Dictionary = {
	"player_position": Vector2.ZERO,  # Posisi player
	"quest_progress": {},            # Progres quest
	"collected_keys": 0,             # Jumlah kunci
	"current_map": "entrance_area"   # Map yang sedang dimainkan
}

# Muat data dari file saat game dimulai
func load_game() -> bool:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file:
			var json_instance = JSON.new()  # Buat instance JSON
			var json_data = file.get_as_text()  # Baca sebagai teks
			var parsed_data = json_instance.parse(json_data)  # Parse JSON
			if parsed_data.error == OK:
				save_data = parsed_data.result  # Ambil hasil parsing
				print("Game loaded successfully!")
				file.close()
				return true
			else:
				print("Error parsing JSON:", parsed_data.error)
		else:
			print("Failed to open save file.")
	else:
		print("No save file found.")
	return false

# Simpan data ke file JSON
func save_game():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		var json_instance = JSON.new()  # Buat instance JSON
		var json_string = json_instance.stringify(save_data)  # Ubah Dictionary ke JSON
		file.store_string(json_string)  # Simpan string JSON ke file
		file.close()
		print("Game saved successfully!")
	else:
		print("Failed to save game.")

# Update data yang disimpan
func update_save_data(updated_data: Dictionary):
	for key in updated_data.keys():
		save_data[key] = updated_data[key]
