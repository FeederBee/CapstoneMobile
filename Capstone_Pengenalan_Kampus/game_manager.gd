extends Node2D

#GlobalVariable
var is_dialog

## Menyimpan progres permainan
#func save_game():
	#var save_data = {
		#"player_position": $Player.position,
		##"quest_status": quest_manager.get_quest_status(),
		##"health": $Player.health
	#}
	#var save_file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	#if save_file:
		#save_file.store_var(save_data)
		#save_file.close()
		#print("Game saved!")
#
## Memuat progres permainan
#func load_game():
	#var save_file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	#if save_file:
		#var save_data = save_file.get_var()
		#save_file.close()
		## Muat data yang disimpan ke dalam game
		#$Player.position = save_data["player_position"]
		##quest_manager.set_quest_status(save_data["quest_status"])
		#$Player.health = save_data["health"]
		#print("Game loaded!")
	#else:
		#print("No save data found.")
