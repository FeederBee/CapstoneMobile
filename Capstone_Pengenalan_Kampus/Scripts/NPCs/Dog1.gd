extends CharacterBody2D

# --- Variabel Ekspor dan Inisialisasi ---
@export var speed: float = 50.0  # Kecepatan gerak anjing
@export var walk_radius: float = 150.0  # Radius maksimal area jalan
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Referensi ke node animasi
@onready var bark_text: Label = $BarkText  # Referensi ke teks saat menggonggong

var home_position: Vector2  # Posisi awal anjing
var target_position: Vector2  # Posisi target acak yang dituju
var is_moving: bool = true  # Status apakah anjing sedang bergerak
var last_direction: Vector2 = Vector2.ZERO  # Arah terakhir untuk menentukan animasi idle
#var velocity: Vector2 = Vector2.ZERO  # Menyimpan kecepatan anjing

# --- Fungsi Utama ---
func _ready() -> void:
	# Menyimpan posisi awal dan mengatur target pertama kali
	home_position = position
	_set_random_target()

func _physics_process(delta: float) -> void:
	# Proses gerakan dan animasi dalam setiap frame
	if is_moving:
		_move_towards_target(delta)
	else:
		_set_to_idle()

# --- Logika Gerakan ---
func _set_to_idle() -> void:
	# Menghentikan gerakan dan memainkan animasi idle
	_play_idle_animation()
	velocity = Vector2.ZERO

func _move_towards_target(delta: float) -> void:
	# Menggerakkan NPC ke arah target
	var direction = (target_position - position).normalized()
	velocity = direction * speed
	
	# Gunakan move_and_slide() untuk menangani gerakan dan collision
	move_and_slide()
	_play_walk_animation(direction)

	# Jika sudah mencapai target, berhenti dan atur target baru setelah jeda
	if position.distance_to(target_position) < 5:
		is_moving = false
		_play_idle_animation()
		_wait_and_set_new_target()

# --- Atur target acak dalam radius ---
func _set_random_target() -> void:
	# Membuat target baru secara acak dalam radius yang telah ditentukan
	var angle = randf_range(0, TAU)  # Acak sudut
	var distance = randf_range(50.0, walk_radius)  # Acak jarak (min 50 untuk stabilitas)
	var random_offset = Vector2(cos(angle), sin(angle)) * distance
	target_position = home_position + random_offset
	is_moving = true

# --- Menunggu sebelum menetapkan target baru ---
func _wait_and_set_new_target() -> void:
	# Memberi jeda sebelum mengatur target baru
	await get_tree().create_timer(2).timeout  # Tunggu 2 detik sebelum target baru
	_set_random_target()

# --- Fungsi untuk Animasi ---
func _play_walk_animation(direction: Vector2) -> void:
	# Memainkan animasi berjalan sesuai arah
	last_direction = direction  # Simpan arah terakhir
	if abs(direction.x) > abs(direction.y):
		animated_sprite.play("walkL" if direction.x < 0 else "walkR")
	else:
		animated_sprite.play("walkU" if direction.y < 0 else "walkD")

func _play_idle_animation() -> void:
	# Memutar animasi idle sesuai arah terakhir
	if abs(last_direction.x) > abs(last_direction.y):
		animated_sprite.play("idleL" if last_direction.x < 0 else "idleR")
	else:
		animated_sprite.play("idleU" if last_direction.y < 0 else "idleD")

# --- Fungsi Callback dari Signal ---
func _on_anjing_body_entered(body: Node2D) -> void:
	# Tindakan ketika anjing bertemu dengan objek lain
	if body.has_method('player'):
		is_moving = false
		bark_text.visible = true
		
		#await get_tree().create_timer(2).timeout
		#is_moving = true
	if body is TileMap:
		_set_to_idle()
		print('ker')
		#_wait_and_set_new_target()

func _on_anjing_body_exited(body: Node2D) -> void:
	# Tindakan ketika objek lain meninggalkan area anjing
	if body.has_method('player'):
		is_moving = true
		bark_text.visible = false
		print('keluar')
	elif body.has_method('object'):
		is_moving = true
