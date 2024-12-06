extends CanvasLayer

@onready var label: Label = $Label
@onready var super_speed: Label = $SuperSpeed
@onready var timer: Timer = $Timer
@onready var active: TouchScreenButton = $Control/active
@onready var deactive: TouchScreenButton = $Control/deactive
@onready var noob: Label = $noob

@onready var player = get_parent()
@onready var deplented_rate = 0

var cheat:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.hide()
	super_speed.hide()
	noob.hide()
	deactive.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timer.stop()
	#label.hide()
	#super_speed.hide()
	


func _on_touch_screen_button_pressed() -> void:
	cheat = true
	active.visible = false
	deactive.visible = true
	if label || super_speed :
		label.show()
		await get_tree().create_timer(2).timeout
		label.visible = false
		await get_tree().create_timer(0.5).timeout
		if cheat:
			super_speed.show()
		else : 
			super_speed.hide()
		await get_tree().create_timer(2).timeout
		super_speed.visible = false


func _on_deactive_pressed() -> void:
	cheat = false
	deactive.visible = false
	active.visible = true
	
	super_speed.visible = false
	label.visible = false
	
	noob.show()
	await get_tree().create_timer(2).timeout
	noob.hide()
	
