extends Node

@onready var anim_player = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.speed_scale = 3.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Fungsi ini dipanggil saat player memasuki area di belakang gedung
func _on_visibility_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		# Ubah modulate bagian atas untuk membuatnya transparan
		anim_player.play("gedung_fadeout")

# Fungsi ini dipanggil saat player keluar dari area di belakang gedung
func _on_visibility_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang keluar dari area adalah player
		anim_player.play("gedung_fadein")

func _on_tulisan_visibility_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		anim_player.play("tulisan_fadeout_fasilkom")

func _on_tulisan_visibility_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		anim_player.play("tulisan_fadeIn_fasilkom")
