extends CharacterBody2D

@export var speed : float = 100
@onready var animated_sprite := $AnimatedSprite2D
#@onready var detection_area := $Area2D # Area2D yang mendeteksi collision

var move_vector := Vector2.ZERO
var last_direction := Vector2.DOWN

var is_colliding_with_npc := false  # Variabel untuk memeriksa apakah player bertabrakan dengan NPC

func _physics_process(_delta: float) -> void:
	move_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Izinkan pergerakan player meskipun bertabrakan, namun deteksi tabrakan bisa memicu event lain
	if move_vector != Vector2.ZERO:
		velocity = move_vector * speed
		move_and_slide()
		_play_walk_animation(move_vector)
		last_direction = move_vector
	else:
		# Hanya masuk ke idle jika tidak ada input pergerakan
		_play_idle_animation()

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

# Fungsi untuk menangani sinyal saat memasuki area NPC
func _on_player_area_entered(area: Area2D) -> void:
	if area.name == "Anjing":  # Atur nama atau properti lain yang sesuai untuk mendeteksi NPC
		is_colliding_with_npc = true
		print('Masuk Anjing')
		#$"../Anjing/text"
		#$CanvasLayer.visible = false
		# Tambahkan logika tambahan untuk saat bertabrakan dengan NPC jika perlu

# Fungsi untuk menangani sinyal saat keluar dari area NPC
func _on_player_area_exited(area: Area2D) -> void:
	if area.name == "Anjing":
		is_colliding_with_npc = false
		$CanvasLayer.visible = true
		print('Keluar Anjing')
