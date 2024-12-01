extends CharacterBody2D

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	animated.play("idle")

func _physics_process(_delta: float) -> void:
	pass
	
func _on_interact():
	Global.player_stop = true
	run_dialog('fasilkom')

func run_dialog(dialog_string):
	Global.is_dialog = true
	Dialogic.start(dialog_string)

func _on_dialog_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		Global.player_stop = true
		Global.is_joystick= false
		print('dialog')
		run_dialog('fasilkom')

func _on_dialogic_signal(argument:String):
	if argument == "activate_something":
		Global.is_joystick= true
		Global.is_dialog = false
		Global.player_stop = false
