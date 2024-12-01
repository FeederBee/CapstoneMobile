extends Node

# Dictionary untuk menyimpan PackedScene dari map
var map_scenes: Dictionary = {
	"entrance_area": null,
	"fasilkom_area": null,
	"fkip_area": null,
	"ftp_area": null,
	"kedokteran_area": null,
	"MainMenu": null
}

# Fungsi untuk memuat semua map ke dalam cache
func preload_maps():
	for map_name in map_scenes.keys():
		var path: String
		if map_name == "MainMenu":
			path = "res://Scenes/UIs/main_menu.tscn"  # Path Main Menu
		else:
			path = "res://Scenes/Map/" + map_name + ".tscn"  # Path map lainnya

		var packed_scene: PackedScene = ResourceLoader.load(path)
		if packed_scene:
			map_scenes[map_name] = packed_scene
		else:
			print("Gagal memuat scene:", path)

# Fungsi untuk mengganti scene ke map tertentu
func change_to_map(map_name: String):
	if map_name in map_scenes and map_scenes[map_name]:
		get_tree().change_scene_to_packed(map_scenes[map_name])
	else:
		print("Scene", map_name, "tidak ditemukan atau belum dimuat!")
