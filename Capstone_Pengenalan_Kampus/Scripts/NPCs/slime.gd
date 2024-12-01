extends CharacterBody2D

# Kecepatan gerak
@export var speed: float = 100.0
@export var close_distance: float = 10.0
@export var patrol_points: Array[Vector2] = []

# Sprite untuk animasi
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Posisi player (diperbarui ketika terdeteksi)
var player_position: Vector2 = Vector2.ZERO
var is_player_detected: bool = false

# Target saat ini
var current_position: Vector2 = global_position
var current_target: Vector2 = current_position + Vector2.ZERO

func _ready():
	pick_random_target()

	# Set animasi awal ke idle
	animated_sprite.play("idle")
	print("Current Position: ", global_position)


func _physics_process(_delta):
	if is_player_detected:
		move_towards(player_position, _delta)
		animated_sprite.play("jump")
	else:
		if position.distance_to(current_target) <= close_distance:
			pick_random_target()
			animated_sprite.play("idle")
		else:
			move_towards(current_target, _delta)
			animated_sprite.play("walk")

func move_towards(target: Vector2, delta: float):
	var direction = (target - position).normalized()
	velocity = direction * speed
	move_and_slide()

	# Flip animasi berdasarkan arah
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false

func pick_random_target():
	if patrol_points.size() > 0:
		current_target = patrol_points[randi() % patrol_points.size()]

func die():
	# Ketika slime mati, mainkan animasi "die"
	animated_sprite.play("die")
	# Nonaktifkan pergerakan
	velocity = Vector2.ZERO
	set_physics_process(false)


func _on_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		is_player_detected = true
		player_position = body.global_position


func _on_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		is_player_detected = false
		pick_random_target()
