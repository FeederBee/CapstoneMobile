extends CharacterBody2D


#@export currentpo = position.x

#@export var mov_speed = Global.global_speed
@export var run_speed = 300
@export var recovery_rate = 5
@export var recovery_delay = 2
@export var depelented_rate = 5
@export var deplented_delay = 0.4 
@export var bg_stamina_delay:float = 0.0

#@onready var ray_cast: RayCast2D = $RayCast2D
@onready var animated_sprite := $AnimatedSprite2D
@onready var detection_area := $Player_detection # Area2D yang mendeteksi collision
@onready var virtual_joystick: VirtualJoystick = $"CanvasLayer/Virtual Joystick"

@onready var state_run: Node = $state_run

#Gerakan
var move_vector := Vector2.ZERO
var last_direction := Vector2.DOWN

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
	else:
		# kecepatan
		if state_run.is_running:
			velocity = move_vector * (Global.global_speed + state_run.run_speed)
		else:
			velocity = move_vector * Global.global_speed
		
		move_and_slide()
		
		#print(Global.global_speed + state_run.run_speed)

		# Atur kecepatan animasi berdasarkan kecepatan player
		var velocity_length = velocity.length()/150
		var animation_speed = 0.5 if velocity_length < 0.5 else velocity_length

		#print(animation_speed)
		
		animated_sprite.speed_scale = animation_speed
		
		_play_walk_animation(move_vector)
		last_direction = move_vector
		# Hanya masuk ke idle jika tidak ada input pergerakan	

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
