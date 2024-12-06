extends Node

#Ngetroll (hapusable)
@onready var nge_troll: CanvasLayer = $"../NgeTroll"

#parent Node
@onready var player: CharacterBody2D = get_parent()
#Progresbar (stamina) Node
@onready var bg_stamina: ProgressBar = $"../BgStamina"
@onready var bar_stamina: ProgressBar = $"../BgStamina/BarStamina"
@onready var run_btn: TouchScreenButton = $"../CanvasLayer/Control/Run_btn"
#Timer Node
@onready var recover_timer: Timer = $"../BgStamina/BarStamina/recover_timer"
@onready var deplented_timer: Timer = $"../BgStamina/BarStamina/deplented_timer"
@onready var bg_timer: Timer = $"../BgStamina/bg_timer"

@onready var run_speed = player.run_speed
@onready var recovery_rate = player.recovery_rate
@onready var recovery_delay = player.recovery_delay
@onready var depelented_rate = player.depelented_rate
@onready var deplented_delay = player.deplented_delay 
@onready var bg_delay = player.bg_stamina_delay

var stamina = 100
var is_running = false
var is_recovering = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg_stamina.value = stamina
	bar_stamina.value = stamina
	bg_stamina.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_running:
		bg_delay = deplented_delay
		if stamina <=0 : 
			is_running = false
			is_recovering = true
		
	elif is_recovering : 
		bg_delay = recovery_delay/2.5
		if stamina >= 100:
			is_recovering = false
			await get_tree().create_timer(3).timeout
			bg_stamina.hide()
		
	print('deplented_rate: ', depelented_rate)
	print('ngetroll: ', nge_troll.cheat)
	
	depelented_rate = 0 if nge_troll.cheat else player.depelented_rate

func _on_run_btn_pressed() -> void:
	if stamina <= 10:
		is_running = false
	else : 
		is_running = true
		is_recovering = false
		stamina -= depelented_rate
		bar_stamina.value = stamina
		deplented_timer.start(deplented_delay)
	
	if bg_timer.is_stopped(): 
		bg_timer.start(bg_delay)
	bg_stamina.show()

func _on_run_btn_released() -> void:
	is_running = false
	is_recovering = true

func _on_recover_timer_timeout() -> void:
	if is_recovering:
		if stamina <= 100:
			recover_timer.start(recovery_delay)
			stamina += recovery_rate
		else :
			is_recovering = false
			recover_timer.stop()
	bar_stamina.value = stamina


func _on_deplented_timer_timeout() -> void:
	if is_running:
		if stamina >=0 :
			stamina -= depelented_rate
			bar_stamina.value = stamina
	else : 
		deplented_timer.stop()
		recover_timer.start(recovery_delay)
	

func _on_bg_timer_timeout() -> void:
	if bg_stamina.value > bar_stamina.value + depelented_rate:
		bg_stamina.value -= depelented_rate
	elif bar_stamina.value == bg_stamina.value || bar_stamina.value == bg_stamina.value + depelented_rate:
		if is_recovering:
			bg_stamina.value += recovery_rate
	else: 
		bg_stamina.value = bar_stamina.value + depelented_rate
		
		
	#if bg_stamina.value == 100 || bg_stamina.value == 0:
	if (!is_running && !is_recovering) || bg_stamina.value == 0:
		bg_timer.stop()
	else:
		bg_timer.start(bg_delay)
