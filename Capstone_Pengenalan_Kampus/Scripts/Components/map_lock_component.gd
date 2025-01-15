extends Node

@onready var parent = get_parent().get_parent()
@onready var quiz_component = $"../QuizComponent"
@onready var player = $"../../Y_sort/Karakter/Player"
#@onready var tickets_count = parent.tickets_count
#@onready var transition_path = parent.transition_path
@onready var current_map_name = quiz_component.current_map_name

@onready var tickets_obtained:int#quiz_component.tickets_obtained
@onready var tickets_count:int#quiz_component.tickets_count

@export var tickets_required:int ## Jumlah tiket minimal untuk menyelesaikan sdan membuka kunci map saat ini

func _ready() -> void:
	$CanvasLayer.visible = false
	tickets_count = quiz_component.tickets_count
	tickets_obtained = quiz_component.get_ticket_obtained()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _process(delta: float) -> void:
	#print(SaveManager.load_data('quiz_progress')['EntranceAreaMap'].values())
	pass

func _on_dialogic_signal(argument:String):
	if argument == 'ticket_obtain':
		tickets_obtained += 1 if tickets_obtained <= tickets_count else 0

func check_data(target_map_name: String) -> bool:
	"""
	Mengecek apakah pemain boleh berpindah ke target_map_name.
	Syarat:
	1. Jika target_map_name adalah map yang sudah selesai, akses diperbolehkan.
	2. Jika target_map_name adalah map yang baru, quest di map saat ini harus selesai.
	
	Returns:
		bool: True jika akses diperbolehkan, False jika tidak.
	"""
	# Memuat data progres dari SaveManager
	var quiz_progress = SaveManager.load_data('quiz_progress')

	# Validasi data progres
	if quiz_progress == null:
		printerr("Quest progress data not found!")
		return false

	# Ambil data quest untuk map saat ini
	var current_quiz = quiz_progress.get(current_map_name, {})
	var completed_count = 0
	var total_quests = current_quiz.size()

	# Hitung jumlah quest yang telah selesai di map saat ini
	for quiz_status in current_quiz.values():
		if quiz_status == "completed":
			completed_count += 1

	# Syarat 1: Target map adalah map yang sudah selesai
	if quiz_progress.has(target_map_name) and target_map_name != current_map_name:
		return true

	# Syarat 2: Target map adalah map baru, tetapi quest di map saat ini harus selesai
	if target_map_name != current_map_name and completed_count == tickets_required:
		return true

	# Jika tidak memenuhi syarat, tolak akses
	return false


func change_map(target_map_name:String, map):
	if !check_data(target_map_name):
		print(check_data(target_map_name))
		print("Oh tidak bisa")
		$CanvasLayer.visible = true
		await get_tree().create_timer(0.5).timeout
		$CanvasLayer.visible = false
		return

	Global.change_map(map)

#Button Touch Signal
#Entrance
func _on_entrance_btn_l_pressed() -> void:
	Global.spawn_position = Vector2(1097, 50)
	change_map('EntranceAreaMap', Global.path_map.ENTRANCE )
	#Global.spawn_position = Vector2(1097, 50)
func _on_entrance_btn_r_pressed() -> void:
	Global.spawn_position = Vector2(2921, 51)
	change_map('EntranceAreaMap', Global.path_map.ENTRANCE )
	
	
#Fasilkom
func _on_fasilkom_btn_pressed() -> void:
	change_map('FasilkomAreaMap', Global.path_map.FASILKOM )
	Global.spawn_position = Vector2(10, 1508)
func _on_fasilkom_btn_l_pressed() -> void:
	change_map('FasilkomAreaMap', Global.path_map.FASILKOM )
	Global.spawn_position = Vector2(1369, 2808)
func _on_fasilkom_btn_r_pressed() -> void:
	change_map('FasilkomAreaMap', Global.path_map.FASILKOM )
	Global.spawn_position = Vector2(2393, 2811)
func _on_fasilkom_btn_up_pressed() -> void:
	change_map('FasilkomAreaMap', Global.path_map.FASILKOM )
	Global.spawn_position = Vector2(2930, 984)
func _on_fasilkom_btn_down_pressed() -> void:
	change_map('FasilkomAreaMap', Global.path_map.FASILKOM )
	Global.spawn_position = Vector2(2930, 1594)
func _on_fasilkom_btn_mid_pressed() -> void:
	change_map('FasilkomAreaMap', Global.path_map.FASILKOM )
	Global.spawn_position = Vector2(2930, 2650)

#FKIP
func _on_fkip_btn_up_pressed() -> void:
	change_map('FKIPAreaMap', Global.path_map.FKIP )
	Global.spawn_position = Vector2(121, 1161)
func _on_fkip_btn_mid_pressed() -> void:
	change_map('FKIPAreaMap', Global.path_map.FKIP )
	Global.spawn_position = Vector2(117, 2058)
func _on_fkip_btn_down_pressed() -> void:
	change_map('FKIPAreaMap', Global.path_map.FKIP )
	Global.spawn_position = Vector2(118, 3355)

#FTP
func _on_ftp_btn_pressed() -> void:
	change_map('FTPAreaMap', Global.path_map.FTP )
	Global.spawn_position = Vector2(4149, 2649)
func _on_ftp_btn_r_pressed() -> void:
	change_map('FTPAreaMap', Global.path_map.FTP )
	Global.spawn_position = Vector2(3864, 3605)
func _on_ftp_btn_l_pressed() -> void:
	change_map('FTPAreaMap', Global.path_map.FTP )
	Global.spawn_position = Vector2(1766, 3604)

#FKG
func _on_fkg_btn_r_pressed() -> void:
	change_map('FKGAreaMap', Global.path_map.FKG )
	Global.spawn_position = Vector2(2634, 58)
func _on_fkg_btn_l_pressed() -> void:
	change_map('FKGAreaMap', Global.path_map.FKG )
	Global.spawn_position = Vector2(1497, 58)
