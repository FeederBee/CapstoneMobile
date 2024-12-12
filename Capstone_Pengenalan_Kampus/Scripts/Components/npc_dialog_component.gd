extends Node

@onready var animated: AnimatedSprite2D = $"../AnimatedSprite2D"
@onready var dialog_timeline_name = get_parent().dialog_timeline_name

@onready var dialog_btn: TouchScreenButton = $CanvasLayer/Control/dialog_btn

func _ready():
	dialog_btn.hide()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	animated.play("idle")

func _physics_process(_delta: float) -> void:
	pass
	
#func _on_interact():
	#Global.player_stop = true
	#run_dialog(dialog_timeline_name)

func run_dialog(dialog_string):
	Global.is_dialog = true
	Dialogic.start(dialog_string)

func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		dialog_btn.hide()
	elif argument == "dialog_finished":
		dialog_btn.show()
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
	run_dialog(dialog_timeline_name)
