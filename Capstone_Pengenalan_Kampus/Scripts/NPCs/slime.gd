# Slime.gd
extends CharacterBody2D

# Variabel pengaturan
@export var speed: float = 100.0  # Kecepatan slime
@export var detection_range: float = 200.0  # Radius deteksi player

# Variabel internal
var player_position: Vector2 = Vector2.ZERO
var is_chasing: bool = false

# Referensi AnimatedSprite2D untuk animasi
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Fungsi untuk menginisialisasi deteksi
func _ready():
	animated_sprite.play("idle")

# Fungsi untuk mengupdate posisi slime
func _process(delta: float):
	if is_chasing:
		# Mengubah animasi menjadi "chase" saat mengejar player
		if animated_sprite.animation != "walk":
			animated_sprite.play("walk")
		# Mengejar player
		position += (player_position - position)/speed
		move_and_slide()
	else:
		# Mengubah animasi menjadi "idle" jika tidak mengejar player
		if animated_sprite.animation != "idle":
			animated_sprite.play("idle")
		# Gerakan acak saat tidak mendeteksi player
		random_walk(delta)

# Fungsi untuk mengejar player
func chase_player(delta: float):
	position += (player_position - position)/speed
	move_and_slide()

# Fungsi untuk gerakan acak (idle)
func random_walk(delta: float):
	# Menentukan arah gerakan acak
	var random_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	velocity = random_direction * (speed / 2)  # Lebih lambat dari kecepatan mengejar
	move_and_slide()

func _on_player_body_entered(body: Node2D) -> void:
		if body.has_method("Player"):
			is_chasing = true
			player_position = body.global_position


func _on_player_body_exited(body: Node2D) -> void:
		if body.has_method("Player"):
			is_chasing = false
