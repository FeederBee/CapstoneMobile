extends Node2D

@onready var anim_player = $AnimationPlayer

func _ready():
	if anim_player:
		print("AnimationPlayer found!")
	else:
		print("AnimationPlayer not found!")

# Fungsi ini dipanggil saat player memasuki area di belakang gedung
func _on_visibility_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		# Ubah modulate bagian atas untuk membuatnya transparan
		anim_player.play("gedung_fadeout")
		
# Fungsi ini dipanggil saat player keluar dari area di belakang gedung
func _on_visibility_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang keluar dari area adalah player
		# Kembalikan opasitas bagian atas gedung ke normal (1)
		anim_player.play("gedung_fadeIn")

func _on_tulisan_visibility_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		anim_player.play("tulisan_fadeout_fasilkom")

func _on_tulisan_visibility_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		anim_player.play("tulisan_fadeIn_fasilkom")
