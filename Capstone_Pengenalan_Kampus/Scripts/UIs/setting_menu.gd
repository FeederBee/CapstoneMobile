extends Control

@onready var parent = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_bgm('main_menu')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_btn_pressed() -> void:
	print('pressed')
	parent.button_component.show()
	hide()
