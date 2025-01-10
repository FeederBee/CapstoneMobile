extends CharacterBody2D

@export var run_speed = 300
@export var recovery_rate = 5
@export var recovery_delay = 2
@export var depelented_rate = 5
@export var deplented_delay = 0.4 
@export var bg_stamina_delay:float = 0.0

@onready var animated_sprite := $AnimatedSprite2D
@onready var detection_area := $Player_detection # Area2D yang mendeteksi collision
@onready var virtual_joystick: VirtualJoystick = $"CanvasLayer/Virtual Joystick"

@onready var state_run: Node = $Components/PlayerRunComponent
@onready var stamina = state_run.stamina

var player_stamina:float = 100

#Gerakan
var move_vector := Vector2.ZERO
var last_direction := Vector2.DOWN
var is_walking:bool
var walk_sfx_speed:float

func _ready() -> void:
	animated_sprite.play("idleU")

func _physics_process(_delta: float) -> void:
	move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Izinkan pergerakan player meskipun bertabrakan, namun deteksi tabrakan bisa memicu event lain
	if Global.player_stop or move_vector == Vector2.ZERO:
		move_vector = Vector2.ZERO
		if Global.is_dialog:
			animated_sprite.play("idleU")
			virtual_joystick.hide()
		else: 
			_play_idle_animation()
			virtual_joystick.show()
		
		is_walking = false
	else:
		# kecepatan
		if state_run.is_running:
			velocity = move_vector * (Global.global_speed + state_run.run_speed)
			
		else:
			velocity = move_vector * Global.global_speed

		move_and_slide()
		
		# Atur kecepatan animasi berdasarkan kecepatan player
		var velocity_length = velocity.length()/100
		var animation_speed = 0.0
		if velocity_length < 0.6:
			animation_speed = 0.6
			walk_sfx_speed = 1
		else :
			animation_speed = velocity_length
			walk_sfx_speed = max(animation_speed,1.55)
		animated_sprite.speed_scale = animation_speed
		
		_play_walk_animation(move_vector)
		is_walking = true
		last_direction = move_vector
		
	stamina = state_run.stamina
	walk_sfx()

func walk_sfx():
	if is_walking:
		AudioManager.set_sfx_pitch(walk_sfx_speed)
		if AudioManager.sfx_is_playing:
			pass
		else : 
			print("play ulang SFX")
			AudioManager.play_sfx("walk")
	else : 
		AudioManager.stop_sfx()

func _play_walk_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			animated_sprite.play("walkL")
		else:
			animated_sprite.play("walkR")
	else:
		if direction.y < 0:
			animated_sprite.play("walkU")
		else:
			animated_sprite.play("walkD")

func _play_idle_animation():
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x < 0:
			animated_sprite.play("idleL")
		else:
			animated_sprite.play("idleR")
	else:
		if last_direction.y < 0:
			animated_sprite.play("idleU")
		else:
			animated_sprite.play("idleD")

func player(_delta):
	pass #Check body entered area

func _on_player_detection_area_entered(area: Area2D) -> void:
	if area.name == 'gedung_visibility':
		#animated_sprite.self_modulate = Color(1, 1, 1, transparency_value)
		pass

func _on_player_detection_area_exited(area: Area2D) -> void:
	if area.name == 'gedung_visibility':
		animated_sprite.self_modulate = Color(1, 1, 1, 1)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.has_method('tree'):
		Global.blur = true