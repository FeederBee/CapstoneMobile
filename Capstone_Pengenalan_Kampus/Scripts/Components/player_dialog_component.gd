extends Node

@onready var action_button = $"../../CanvasLayer/ActionButton"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		action_button.hide()
	elif argument =="dialog_finished":
		action_button.show()
