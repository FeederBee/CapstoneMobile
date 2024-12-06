extends Node

@onready var bgm_player: AudioStreamPlayer = $BGMPlayer
@onready var sfx_player_button: AudioStreamPlayer = $SFXPlayer_Button
@onready var sfx_player_movement: AudioStreamPlayer = $SFXPlayer_Movement
@onready var sfx_player_interaction: AudioStreamPlayer = $SFXPlayer_Interaction
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#Volume
var music_volume: float = 0.5

@export var bgm_files : Dictionary = {
	"main_menu" : "res://Audio/2. Crazy Dave Intro.mp3",
	"entrance_area": "res://Audio/04. Grasswalk.mp3",
	"fasilkom_area": "res://Audio/2. Crazy Dave Intro.mp3",
	"ftp_area": "res://Audio/2. Crazy Dave Intro.mp3"
	}

@export var sfx_files : Dictionary

# Contoh pengisian file audio
func _ready():

	print("AudioManager ready!")

	#sfx_files = {
		#"button": "res://Audio/SFX/button_pressed.ogg",
		#"movement": "res://Audio/SFX/footsteps.ogg",
		#"interaction": "res://Audio/SFX/interaction.ogg"
	#}

func play_bgm(map_name: String) -> void:
	var bgm_path = bgm_files.get(map_name, "")
	if bgm_path != "":
		bgm_player.stream = load(bgm_path)
		animation_player.play("bgm_fadeIn")
		bgm_player.play()
		

func stop_bgm() -> void:
	animation_player.play("bgm_fadeOut")  # Memulai animasi fade out
	# Tunggu animasi selesai sebelum menghentikan BGM
	await animation_player.animation_finished
	bgm_player.stop()

func play_sfx(sfx_type: String) -> void:
	var sfx_path = sfx_files.get(sfx_type, "")
	if sfx_path != "":
		var player = get_node("SFXPlayer_" + sfx_type.capitalize())
		player.stream = load(sfx_path)
		player.play()
