extends Node2D

# Referensi ke bagian atas gedung yang akan transparan
#@onready var bagian_atas = $Atas
#@onready var bagian_atas = $FasilkomGedung
@onready var anim_player = $AnimationPlayer
@export var transparency_value: float = 0.5  # Nilai transparansi untuk bagian atas gedung (0 - 1)



func _ready():
	if anim_player:
		print("AnimationPlayer found!")
	else:
		print("AnimationPlayer not found!")

# Fungsi ini dipanggil saat player memasuki area di belakang gedung
func _on_visibility_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		# Ubah modulate bagian atas untuk membuatnya transparan
		#bagian_atas.modulate.a = transparency_value
		anim_player.play("gedung_fadeout")
		
# Fungsi ini dipanggil saat player keluar dari area di belakang gedung
func _on_visibility_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang keluar dari area adalah player
		# Kembalikan opasitas bagian atas gedung ke normal (1)
		#bagian_atas.modulate.a = 1.0
		anim_player.play("gedung_fadeIn")

func _on_tulisan_visibility_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		anim_player.play("tulisan_fadeout_fasilkom")

func _on_tulisan_visibility_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Cek apakah yang memasuki area adalah player
		anim_player.play("tulisan_fadeIn_fasilkom")
