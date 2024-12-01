extends CharacterBody2D

# === Parameter NPC ===
@export var patrol_radius: float = 200.0  # Radius area patroli
@export var speed: float = 50.0  # Kecepatan gerakan NPC

# === Referensi animasi dan komponen ===
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var patrol_center: Vector2 = global_position  # Posisi pusat patroli
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# === Variabel internal ===
var target_position: Vector2  # Posisi target selanjutnya
var is_idle: bool = false  # Status idle
var is_waking_up: bool = false  # Status transisi dari idle ke walk
var current_direction: String = "down"  # Arah terakhir (untuk animasi)
var idle_timer: Timer

func _ready():
	# Timer untuk idle sesekali
	idle_timer = Timer.new()
	idle_timer.wait_time = rng.randf_range(4.0, 10.0)
	idle_timer.autostart = false
	idle_timer.one_shot = true
	idle_timer.connect("timeout", Callable(self, "_on_idle_timeout"))
	add_child(idle_timer)
	
	set_new_target()  # Set target pertama

func _physics_process(delta):
	if is_idle or is_waking_up:
		return  # NPC tidak bergerak jika sedang idle atau transisi wake_up
	
	move_towards_target(delta)
	update_animation()

func set_new_target():
	"""
	Pilih posisi acak dalam radius sebagai target.
	"""
	var angle = rng.randf_range(0, TAU)  # Sudut acak dalam lingkaran
	var distance = rng.randf_range(0, patrol_radius)  # Jarak acak dalam radius
	target_position = patrol_center + Vector2(cos(angle), sin(angle)) * distance
	is_idle = false
	is_waking_up = true
	play_wake_up_animation()

func move_towards_target(_delta):
	"""
	Gerakkan NPC menuju target posisi. Jika sudah sampai, beralih ke idle atau target baru.
	"""
	if global_position.distance_to(target_position) < 5.0:
		start_idle()
		return
	
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func start_idle():
	"""
	Masuk ke mode idle sebelum bergerak ke target berikutnya.
	"""
	is_idle = true
	velocity = Vector2.ZERO
	idle_timer.start()  # Mulai timer untuk idle
	play_idle_animation()

func play_idle_animation():
	"""
	Mainkan animasi idle berdasarkan arah terakhir.
	Periksa apakah animasi ada di daftar animasi AnimatedSprite2D.
	"""
	var animation_name = "idle_" + current_direction
	if animation_name in animated_sprite.sprite_frames.get_animation_names():
		animated_sprite.play(animation_name) 
		#await get_tree().create_timer(4).timeout
	else:
		push_error("Animation '" + animation_name + "' not found!")

func _on_idle_timeout():
	"""
	Callback setelah selesai idle, set target baru.
	"""
	is_idle = false  # Reset status idle
	set_new_target()

func play_stop_animation():
	"""
	Mainkan animasi stop sebelum idle.
	"""
	animated_sprite.play("stop_" + current_direction)

func play_wake_up_animation():
	"""
	Mainkan animasi wake_up sebelum mulai berjalan.
	"""
	var animation_name = "wake_" + current_direction
	if animation_name in animated_sprite.sprite_frames.get_animation_names():
		animated_sprite.play(animation_name)
		await get_tree().create_timer(1).timeout
		_on_wake_up_finished()
	else:
		push_error("Animation '" + animation_name + "' not found!")
		_on_wake_up_finished()  # Jika animasi tidak ada, langsung ke walk.


func _on_wake_up_finished():
	"""
	Callback setelah animasi wake_up selesai.
	"""
	if is_waking_up:
		is_waking_up = false
		update_animation()  # Mulai animasi walk

func update_animation():
	"""
	Update animasi berdasarkan arah gerakan.
	"""
	if velocity == Vector2.ZERO:
		return  # Jangan ubah animasi jika tidak bergerak
	
	var anim_direction = ""
	if abs(velocity.x) > abs(velocity.y):  # Gerakan horizontal lebih dominan
		anim_direction = "left" if velocity.x < 0 else "right"
	else:  # Gerakan vertikal lebih dominan
		anim_direction = "up" if velocity.y < 0 else "down"
	
	current_direction = anim_direction  # Simpan arah saat ini
	
	animated_sprite.play("walk_" + anim_direction)
