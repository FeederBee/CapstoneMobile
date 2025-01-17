extends Control

@onready var parent = get_parent().get_parent()
#@onready var canvas_layer: CanvasLayer = $"../../Credits/CanvasLayer"
@onready var credit_button: TouchScreenButton = $"../../Button/CreditButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.auto_save_is = false
	AudioManager.play_bgm('main_menu')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_back_btn_pressed() -> void:
	AudioManager.play_sfx("button_click")
	print('pressed')
	parent.button.show()
	credit_button.show()
	hide()
