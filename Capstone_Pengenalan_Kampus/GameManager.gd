# GameManager.gd
extends Node

# Deklarasi variabel untuk referensi ke node Player
var player : CharacterBody2D  # Deklarasikan tipe jika menggunakan Typed GDScript

func save_game():
	if player:
		var save_data = {
			"player_position": player.position,
			#"health": player.health
			# Tambahkan data lain jika perlu
		}
		var save_file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
		if save_file:
			save_file.store_var(save_data)
			save_file.close()
			print("Game saved!")
	else:
		print("Player reference not found!")

# Memuat progres permainan
func load_game():
	print("Attempting to load game...")
	var save_file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if save_file:
		print("Save file found.")
		if save_file.get_len() > 0:
			print("File has data, attempting to load...")
			var save_data = save_file.get_var()
			print("Data loaded:", save_data)

			# Cek struktur data yang diharapkan
			if save_data.has("player_position") and save_data.has("health"):
				player.position = save_data["player_position"]
				player.health = save_data["health"]
				print("Game loaded successfully!")
			else:
				print("Error: Data structure mismatch.")
		else:
			print("Save file is empty.")
	else:
		print("Save file not found.")
