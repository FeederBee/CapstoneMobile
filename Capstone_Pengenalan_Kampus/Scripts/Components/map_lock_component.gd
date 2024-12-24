extends Node

@onready var parent = get_parent().get_parent()
@onready var quiz_component = $"../QuizComponent"
#@onready var tickets_count = parent.tickets_count
@onready var transition_path = parent.transition_path

@onready var tickets_obtained:int#quiz_component.tickets_obtained
@onready var tickets_count:int#quiz_component.tickets_count

@export var tickets_required:int

func _ready() -> void:
	tickets_count = quiz_component.tickets_count
	tickets_obtained = quiz_component.get_ticket_obtained()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _process(delta: float) -> void:
	print(tickets_obtained)

func _on_dialogic_signal(argument:String):
	if argument == 'ticket_obtain':
		tickets_obtained += 1 if tickets_obtained <= tickets_count else 0

func change_map(map, transition):
	if tickets_obtained != tickets_required:
		print("Oh tidak bisa")

	Global.change_map(map, transition)

#Button Touch Signal
#Entrance
func _on_entrance_btn_l_pressed() -> void:
	change_map(Global.path_map.ENTRANCE, transition_path)
	Global.spawn_position = Vector2(1097, 50)
func _on_entrance_btn_r_pressed() -> void:
	change_map(Global.path_map.ENTRANCE, transition_path)
	Global.spawn_position = Vector2(2921, 51)
	
#Fasilkom
func _on_fasilkom_btn_pressed() -> void:
	change_map(Global.path_map.FKG, transition_path)
	Global.spawn_position = Vector2(10, 1508)
func _on_fasilkom_btn_l_pressed() -> void:
	change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(1369, 2808)
func _on_fasilkom_btn_r_pressed() -> void:
	change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2393, 2811)
func _on_fasilkom_btn_up_pressed() -> void:
	change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2930, 984)
func _on_fasilkom_btn_down_pressed() -> void:
	change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2930, 1594)
func _on_fasilkom_btn_mid_pressed() -> void:
	change_map(Global.path_map.FASILKOM, transition_path)
	Global.spawn_position = Vector2(2930, 2650)

#FKIP
func _on_fkip_btn_up_pressed() -> void:
	change_map(Global.path_map.FKIP, transition_path)
	Global.spawn_position = Vector2(121, 1161)
func _on_fkip_btn_mid_pressed() -> void:
	change_map(Global.path_map.FKIP, transition_path)
	Global.spawn_position = Vector2(117, 2058)
func _on_fkip_btn_down_pressed() -> void:
	change_map(Global.path_map.FKIP, transition_path)
	Global.spawn_position = Vector2(118, 3355)

#FTP
func _on_ftp_btn_pressed() -> void:
	change_map(Global.path_map.FTP, transition_path)
	Global.spawn_position = Vector2(4149, 2649)
func _on_ftp_btn_r_pressed() -> void:
	change_map(Global.path_map.FTP, transition_path)
	Global.spawn_position = Vector2(3864, 3605)
func _on_ftp_btn_l_pressed() -> void:
	change_map(Global.path_map.FTP, transition_path)
	Global.spawn_position = Vector2(1766, 3604)

#FKG
func _on_fkg_btn_r_pressed() -> void:
	change_map(Global.path_map.FKG, transition_path)
	Global.spawn_position = Vector2(2634, 58)
func _on_fkg_btn_l_pressed() -> void:
	change_map(Global.path_map.FKG, transition_path)
	Global.spawn_position = Vector2(1497, 58)
