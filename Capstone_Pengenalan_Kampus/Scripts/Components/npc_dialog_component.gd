extends Node

@onready var animated: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var dialog_timeline_quest_name = get_parent().dialog_timeline_quest_name
@onready var dialog_timeline_name = get_parent().dialog_timeline_done_name

@onready var dialog_btn: TouchScreenButton = $CanvasLayer/Control/DialogBtn

func _ready():
	dialog_btn.hide()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	animated.play("idle")

func _physics_process(_delta: float) -> void:
	pass

func run_dialog(dialog_string):
	Global.is_dialog = true
	Dialogic.start(dialog_string)
	
func check_quiz_progress(quest_name: String = dialog_timeline_quest_name):
	var quiz_progress = SaveManager.load_data("quiz_progress")
	# Periksa apakah quiz_progress tidak null
	if quiz_progress != null:
		# Iterasi semua map dalam quest_progress
		for map_name in quiz_progress.keys():
			# Ambil data quest untuk map tersebut
			var map_quests = quiz_progress.get(map_name, {})
			# Cek apakah quest_name ada di map_quests dan apakah statusnya "completed"
			if map_quests.has(quest_name) and map_quests[quest_name] == "completed":
				return true  # Quest ditemukan selesai di salah satu map
		
	return false  # Quest tidak ditemukan atau belum selesai

func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		dialog_btn.hide()
	elif argument == "dialog_finished":
		#if dialog_timeline_quest_name == Dialogic.VAR.TimelineName:
			#dialog_btn.show()
		Global.is_joystick= true
		Global.is_dialog = false
		Global.player_stop = false
	elif argument == 'dialog_ended':
		#if dialog_timeline_quest_name == Dialogic.VAR.TimelineName:
			#dialog_btn.show()
		Global.is_joystick= true
		Global.is_dialog = false
		Global.player_stop = false

func _on_dialog_area_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		dialog_btn.show()

func _on_dialog_area_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		dialog_btn.hide()

func _on_dialog_btn_pressed() -> void:
	Global.player_stop = true
	Global.is_joystick= false
	print('dialog')
	
	if check_quiz_progress():
		run_dialog(dialog_timeline_name)
		print (dialog_timeline_name)
	else: 
		run_dialog(dialog_timeline_quest_name)
		print (dialog_timeline_quest_name)
