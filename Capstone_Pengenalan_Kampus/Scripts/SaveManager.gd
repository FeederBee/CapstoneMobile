# File: SaveManager.gd
extends Node
#@tool  # Menjadikan node aktif di editor

@export var save_file_path: String = "user://save_game.json"

# Variabel untuk menyimpan data permainan
var player_position: Vector2 = Vector2(0, 0)
var current_level: int = 1
var quest_progress: Dictionary = {}

# Fungsi untuk menyimpan data permainan ke file lokal
func save_game_data():
	var file = FileAccess.open(save_file_path, FileAccess.ModeFlags.WRITE)
	if file:
		var data = {
			"player_position": player_position,
			"current_level": current_level,
			"quest_progress": quest_progress
		}
		file.store_string(JSON.stringify(data))  # Serialize data ke JSON dan simpan sebagai string
		file.close()
		print("Data permainan berhasil disimpan.")
	else:
		print("Gagal menyimpan data permainan.")

# Fungsi untuk memuat data permainan dari file lokal
func load_game_data():
	var file = FileAccess.open(save_file_path, FileAccess.ModeFlags.READ)
	if file:
		var json_text = file.get_as_text()
		var data = JSON.parse(json_text)
		file.close()
		
		if data.error == OK:
			# Mengambil data dari hasil parsing JSON
			var json_data = data.result
			player_position = json_data.get("player_position", Vector2(0, 0))
			current_level = json_data.get("current_level", 1)
			quest_progress = json_data.get("quest_progress", {})
			print("Data permainan berhasil dimuat.")
		else:
			print("Error: JSON data tidak valid.")
	else:
		print("File data permainan tidak ditemukan.")

# Fungsi untuk mengupdate posisi player
func update_player_position(new_position: Vector2):
	player_position = new_position
	print("Posisi pemain diperbarui:", player_position)

# Fungsi untuk mengupdate progress quest
func update_quest_progress(quest_name: String, progress: int):
	quest_progress[quest_name] = progress
	print("Progress quest diperbarui:", quest_progress)
