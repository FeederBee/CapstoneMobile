extends Node

@export var current_map_name:String

@export var tickets_count:int = 0 ## jumlah minimal tiket yang harus di dapatkan oleh player untuk bisa next map

var tickets_obtained:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	tickets_obtained = get_ticket_obtained()
	inisiation_tickets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_tickets_obtain()
	print(tickets_obtained)

func data_ticket_obtained():
	var quest_progress = SaveManager.load_data("quiz_progress")
	if quest_progress == null :
		printerr("Progress data not found!")
		return null
	
	var completed_count = 0
	if quest_progress.has(current_map_name):
		var quests = quest_progress[current_map_name]
		# Menghitung jumlah quest dengan status "completed"
		for quest_status in quests.values():
			if quest_status == "completed":
				completed_count += 1
		tickets_obtained = completed_count
		return tickets_obtained
	else: 
		printerr(current_map_name, " not found in quest progress data!")
		
# Fungsi utama untuk mendapatkan jumlah tiket yang diperoleh
func get_ticket_obtained():
	# Memanggil fungsi untuk memuat data progres tiket
	var data = data_ticket_obtained()
	# Mengembalikan jumlah tiket yang diperoleh, atau 0 jika data tidak valid
	return data if data != null else 0
	
func checking_data_quest_progress():
	var quiz_progress = SaveManager.load_data("quiz_progress")
	# Periksa apakah quiz_progress tidak null
	if quiz_progress != null:
		# Periksa apakah key "FasilkomAreaMap" ada
		if quiz_progress.has(current_map_name):
			var map_name = quiz_progress[current_map_name]
			# Periksa apakah key "fasilkom" ada di FasilkomAreaMap
			if map_name.has(Dialogic.VAR.TimelineName):
				# Periksa apakah value dari "fasilkom" adalah "completed"
				if map_name[Dialogic.VAR.TimelineName] == "completed":
					return true
		return false

func inisiation_tickets(valid=true):
	if valid == false:
		return

	if tickets_count == 1:
		$CanvasLayer/Control/TicketsKosong1.visible = true
	elif tickets_count == 2:
		$CanvasLayer/Control/TicketsKosong1.visible = true
		$CanvasLayer/Control/TicketsKosong2.visible = true
	
	elif tickets_count == 3:
		$CanvasLayer/Control/TicketsKosong1.visible = true
		$CanvasLayer/Control/TicketsKosong2.visible = true
		$CanvasLayer/Control/TicketsKosong3.visible = true
	
	elif tickets_count == 4:
		$CanvasLayer/Control/TicketsKosong1.visible = true
		$CanvasLayer/Control/TicketsKosong2.visible = true
		$CanvasLayer/Control/TicketsKosong3.visible = true
		$CanvasLayer/Control/TicketsKosong4.visible = true
	
	elif tickets_count == 5:
		$CanvasLayer/Control/TicketsKosong1.visible = true
		$CanvasLayer/Control/TicketsKosong2.visible = true
		$CanvasLayer/Control/TicketsKosong3.visible = true
		$CanvasLayer/Control/TicketsKosong4.visible = true
		$CanvasLayer/Control/TicketsKosong5.visible = true
		
	elif tickets_count == 0 : 
		$CanvasLayer/Control/TicketsKosong1.visible = false
		$CanvasLayer/Control/TicketsKosong2.visible = false
		$CanvasLayer/Control/TicketsKosong3.visible = false
		$CanvasLayer/Control/TicketsKosong4.visible = false
		$CanvasLayer/Control/TicketsKosong5.visible = false

func hide_tickets_in_dialog():
	if Global.is_dialog:
		$CanvasLayer/Control.visible = false
		return
	$CanvasLayer/Control.visible = true

func show_tickets_obtain():
	tickets_obtained = get_ticket_obtained() if get_ticket_obtained()!=null else 0
	hide_tickets_in_dialog()

	#print("Quest yang selesai di FasilkomAreaMap:", completed_count)
	if tickets_obtained == 1:
		$CanvasLayer/Control/Tickets1.visible = true
	elif tickets_obtained == 2:
		$CanvasLayer/Control/Tickets1.visible = true
		$CanvasLayer/Control/Tickets2.visible = true
	
	elif tickets_obtained == 3:
		$CanvasLayer/Control/Tickets1.visible = true
		$CanvasLayer/Control/Tickets2.visible = true
		$CanvasLayer/Control/Tickets3.visible = true
	
	elif tickets_obtained == 4:
		$CanvasLayer/Control/Tickets1.visible = true
		$CanvasLayer/Control/Tickets2.visible = true
		$CanvasLayer/Control/Tickets3.visible = true
		$CanvasLayer/Control/Tickets4.visible = true
	
	elif tickets_obtained == 5:
		$CanvasLayer/Control/Tickets1.visible = true
		$CanvasLayer/Control/Tickets2.visible = true
		$CanvasLayer/Control/Tickets3.visible = true
		$CanvasLayer/Control/Tickets4.visible = true
		$CanvasLayer/Control/Tickets5.visible = true
		
	elif tickets_obtained == 0 : 
		$CanvasLayer/Control/Tickets1.visible = false
		$CanvasLayer/Control/Tickets2.visible = false
		$CanvasLayer/Control/Tickets3.visible = false
		$CanvasLayer/Control/Tickets4.visible = false
		$CanvasLayer/Control/Tickets5.visible = false

func save_quiz_progress():
	var data = SaveManager.load_data('quiz_progress')
	var new_data = {Dialogic.VAR.TimelineName : Dialogic.VAR.QuizResult}
	
	if data == null:
		SaveManager.save({
					"quiz_progress": {current_map_name : new_data}
				})
	elif data != null and not data.has(current_map_name):
		SaveManager.save({
					"quiz_progress": data.merged({current_map_name : new_data})
				})
	else: 
		if data.has(current_map_name):
			if checking_data_quest_progress() and new_data == {"":""}:
				return
			
			if data[current_map_name].has(Dialogic.VAR.TimelineName) and !checking_data_quest_progress():
				data[current_map_name][Dialogic.VAR.TimelineName] = Dialogic.VAR.QuizResult

			data[current_map_name] = data[current_map_name].merged(new_data)

		SaveManager.save({
				"quiz_progress": data
			})

func get_all_ticketobtained() -> int:
	# Memuat data progres kuis dari SaveManager
	var quiz_progress = SaveManager.load_data("quiz_progress")
	var quiz_completed = 0
	
	# Pastikan data kuis ada sebelum melanjutkan
	if quiz_progress != null:
		# Iterasi melalui setiap map untuk menghitung kuis yang selesai
		for map_name in quiz_progress.keys():
			var map_progress = quiz_progress[map_name]
			# Pastikan map_progress adalah dictionary
			if map_progress is Dictionary:
				for quiz_name in map_progress.keys():
					# Periksa apakah status kuis adalah "completed"
					if map_progress[quiz_name] == "completed":
						quiz_completed += 1
			else:
				printerr("Invalid data format for map_progress: ", map_name)
	else:
		printerr("Quiz progress data is null or corrupted.")
		
	return quiz_completed

func _on_dialogic_signal(argument):
	if argument == 'quiz_result_save' and current_map_name != 'EntranceAreaMap':
		save_quiz_progress()
		
	if argument == 'dialog_finished':
		await get_tree().create_timer(1).timeout
		if get_all_ticketobtained() == 16:
			await get_tree().create_timer(1).timeout
			Global.change_map(Global.path_map.ENDINGCUTSCENE)
