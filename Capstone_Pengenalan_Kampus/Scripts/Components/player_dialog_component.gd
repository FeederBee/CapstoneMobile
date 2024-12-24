extends Node

@onready var action_button = $"../../CanvasLayer/ActionButton"
@onready var bg_stamina: TextureProgressBar = $"../../CanvasLayer/BgStamina"
@onready var player_profile: Control = $"../../CanvasLayer/PlayerProfile"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.is_dialog == true:
		bg_stamina.hide()
		player_profile.visible = false
		return
		
	bg_stamina.show()
	player_profile.visible = true

func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		action_button.hide()
	elif argument =="dialog_finished":
		action_button.show()
