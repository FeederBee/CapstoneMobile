extends CharacterBody2D

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _physics_process(_delta: float) -> void:
	pass

func run_dialog(dialog_string):
	global_variable.is_dialog = true
	
	Dialogic.start(dialog_string)

func _on_dialog_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		global_variable.is_dialog = true
		print('dialog')
		run_dialog('Hello')

func _on_dialogic_signal(argument:String):
	if argument == "activate_something":
		print("Something was activated!")
