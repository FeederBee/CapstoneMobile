extends Node

@export var map_name:String

@export var tickets_count:int = 0 ## jumlah minimal tiket yang harus di dapatkan oleh player untuk bisa next map

var tickets_obtained:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	inisiation_tickets()
	tickets_obtained = get_ticket_obtained()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show_tickets_obtain()

func data_ticket_obtained():
	var quest_progress = SaveManager.load_data("quiz_progress")
	if quest_progress == null:
		printerr("Quest progress data not found!")
		return null
	
	if quest_progress.has(map_name):
		var quests = quest_progress[map_name]
		# Menghitung jumlah quest dengan status "completed"
		var completed_count = 0
		for quest_status in quests.values():
			if quest_status == "completed":
				completed_count += 1
			else : 
				completed_count -= 1 if completed_count > 0 else 0
		tickets_obtained = completed_count
		return tickets_obtained
	else: 
		printerr(map_name, " not found in quest progress data!")
		
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
		if quiz_progress.has(map_name):
			var map_name = quiz_progress[map_name]
			# Periksa apakah key "fasilkom" ada di FasilkomAreaMap
			if map_name.has(Dialogic.VAR.TimelineName):
				#print(map_name.has(Dialogic.VAR.TimelineName))
				# Periksa apakah value dari "fasilkom" adalah "completed"
				if map_name[Dialogic.VAR.TimelineName] == "completed":
					return true
		return false

func inisiation_tickets():
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

func show_tickets_obtain():
	tickets_obtained = data_ticket_obtained()
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
	
	if data != null:
		if data.has(map_name):
			if checking_data_quest_progress() and new_data == {"":""}:
				return
			
			if data[map_name].has(Dialogic.VAR.TimelineName):
				data[map_name][Dialogic.VAR.TimelineName] = Dialogic.VAR.QuizResult

			data[map_name] = data[map_name].merged(new_data)
		SaveManager.save({
				"quiz_progress": data
			})
	
func _on_dialogic_signal(argument):
	if argument == 'quiz_result_save':
		save_quiz_progress()
