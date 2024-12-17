extends Node

# Nama file save
const AUTO_SAVE_FILE_PATH: String = "res://Save Game/AutoSave.json"	# File path untuk save

# Data yang akan disimpan
var save_data: Dictionary = {}
const ALLOWED_KEYS: Array = [
	"timestamp", 
	"player_x_position",
	"player_y_position", 
	"player_stamina",
	"current_map",
	"music_volume", 
	"sfx_volume", 
	"quest_progress"]

func _ready() -> void:
	# Muat data jika ada file save
	#if FileAccess.file_exists(AUTO_SAVE_FILE_PATH):
		#save_data = _load_save_file()
	#else:
		#save_data = {}
	save_data = _load_save_file()
	print(save_data)
	print(load_data('current_map'))

# Fungsi untuk menyimpan data spesifik
func save(properties: Dictionary) -> void:
	"""
	Menyimpan properti ke file save.
	:param properties: Dictionary berisi properti yang ingin disimpan.
	"""
	for key in properties.keys():
		if key in ALLOWED_KEYS:
			save_data[key] = properties[key]
		else:
			print("Key '{}' tidak diizinkan untuk disimpan.".format(key))
	_write_save_file(save_data)


# Fungsi untuk memuat data berdasarkan properti
func load_data(key: String) -> Variant:
	"""
	Memuat data dari file save berdasarkan kunci.
	:param key: Nama properti yang ingin dimuat.
	:return: Nilai properti yang disimpan, atau null jika tidak ada.
	"""
	if save_data.has(key):
		return save_data[key]
	return null

# Fungsi privat untuk menulis ke file
func _write_save_file(data: Dictionary) -> void:
	"""
	Menulis data ke file JSON.
	:param data: Dictionary yang ingin disimpan.
	"""
	var json_string = JSON.stringify(data, "\t") # Gunakan indentasi untuk lebih rapi
	var file = FileAccess.open(AUTO_SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_line(json_string) # Simpan sebagai satu baris
		file.close()
	else:
		print("Tidak dapat menyimpan file!")

# Fungsi privat untuk membaca file save
func _load_save_file() -> Dictionary:
	"""
	Membaca file save dan mengembalikan data sebagai Dictionary.
	:return: Dictionary berisi data yang disimpan.
	"""
	var file = FileAccess.open(AUTO_SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		#
		#var parsed_data = JSON.parse_string(content)
		#return parsed_data # Ubah ke Dictionary
	#return {}
	#var content = file.get_as_text()
	#file.close()
		
		var parsed_data = JSON.parse_string(content)
		return parsed_data # Ubah ke Dictionary
	return {}
