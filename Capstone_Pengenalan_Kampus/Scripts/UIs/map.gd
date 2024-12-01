extends TileMap

@export var render_distance := 1500  # Jarak maksimal render dalam piksel dari Camera2D
var camera: Camera2D  # Variabel untuk referensi Camera2D yang berada di Player

func _ready():
	# Cari Camera2D di dalam node Player di scene utama
	camera = get_node("/root/Main/Player/Camera2D")
	if not camera:
		push_error("Camera2D tidak ditemukan. Pastikan Camera2D berada di dalam Player.")

func _process(_delta):
	if camera:
		update_visible_tiles()

func update_visible_tiles():
	# Dapatkan posisi kamera dalam grid tiles
	var camera_cell = local_to_map(camera.global_position)
	# Loop untuk menentukan batas area render di sekitar kamera
	for x in range(camera_cell.x - 10, camera_cell.x + 10):
		for y in range(camera_cell.y - 10, camera_cell.y + 10):
			var cell_position = Vector2i(x, y)  # Gunakan Vector2i untuk posisi tile
			var world_position = map_to_local(cell_position)

		# Mengaktifkan tile hanya jika berada dalam render_distance
			if (camera.global_position - world_position).length() <= render_distance:
				# Set tile ke tipe yang sesuai (mengaktifkan tile)
				set_cell(0, cell_position, get_cell_source_id(0, cell_position))
			else:
				# Set tile ke -1 untuk menyembunyikan tile di luar jangkauan
				set_cell(0, cell_position, -1)

func obje():
	pass

func _on_pause_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_pause_released() -> void:
	pass # Replace with function body.
