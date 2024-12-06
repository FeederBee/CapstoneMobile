extends ProgressBar
#
#@onready var bar_stamina: ProgressBar = $BarStamina
#@onready var timer: Timer = $BarStamina/Timer
#@onready var run_btn: TouchScreenButton = $"../CanvasLayer/Control/Run_btn"
#
#var recovery_rate = 10
#var recovery_delay = 1
#var depelented_rate = 10
#var deplented_delay = 1
#
#var stamina = 100
#var is_running = false
#var is_recovering = false
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#value = stamina
	#bar_stamina.value = stamina
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if is_running:
		#if stamina <=0 : 
			#is_running = false
			#is_recovering = true
		#
#
#func _on_run_btn_pressed() -> void:
	#if stamina <= 10:
		#is_running = false
	#else : 
		#is_running = true
		#is_recovering = false
	#show()
#
#func _on_run_btn_released() -> void:
	#is_running = false
	#is_recovering = true
#
#
#func _on_recover_timer_timeout() -> void:
	#if is_recovering:
		#if stamina <= 100:
			#stamina += recovery_rate
		#else :
			#is_recovering = false
#
#
#func _on_deplented_timer_timeout() -> void:
	#if stamina >=0 && is_running:
		#stamina -= depelented_rate
	#else : 
		#pass
