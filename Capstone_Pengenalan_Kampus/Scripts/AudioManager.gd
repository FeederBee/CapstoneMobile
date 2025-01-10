extends Node

@onready var bgm_player: AudioStreamPlayer = $BGMPlayer
@onready var sfx_player_button: AudioStreamPlayer = $SFXPlayer_Button
@onready var sfx_player_movement: AudioStreamPlayer = $SFXPlayer_Movement
@onready var sfx_player_interaction: AudioStreamPlayer = $SFXPlayer_Interaction
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#Volume
var music_volume: float = 2 #default music volume
var sfx_volume:float = 4 #default sfx volume

var sfx_is_playing:bool
var playing_position:float

@export var bgm_files : Dictionary = {
	"main_menu" : "res://Audio/Main Menu.mp3",
	"entrance_area": "res://Audio/IN Game.mp3",
	"fasilkom_area": "res://Audio/IN Game.mp3",
	"ftp_area": "res://Audio/IN Game.mp3",
	"fkg_area": "res://Audio/IN Game.mp3",
	"credit": "res://Audio/Credit.mp3"
	}

@export var sfx_files : Dictionary = {
	"walk" : "res://Audio/walking.mp3",
	"button_click" : "res://Audio/4. Click.mp3"
}

# Contoh pengisian file audio
func _ready():
	print("AudioManager ready!")

func play_bgm(map_name: String) -> void:
	var bgm_path = bgm_files.get(map_name, "")
	if bgm_path != "":
		bgm_player.stream = load(bgm_path)
		animation_player.play("bgm_fadeIn")
		await animation_player.animation_finished
		bgm_player.play()
		

func stop_bgm() -> void:
	animation_player.play("bgm_fadeOut")  # Memulai animasi fade out
	# Tunggu animasi selesai sebelum menghentikan BGM
	await animation_player.animation_finished
	bgm_player.stop()

func play_sfx(sfx_name: String) -> void:
	var sfx_path = sfx_files.get(sfx_name, "")
	if sfx_path != "" and sfx_name == "walk":
		sfx_player_movement.stream = load(sfx_path)
		sfx_player_movement.play(playing_position)
	elif sfx_path != "" and sfx_name == "button_click":
		sfx_player_button.stream = load(sfx_path)
		sfx_player_button.play(playing_position)
	sfx_is_playing = true
	
func set_sfx_pitch(pitch_scale:float=1):
	sfx_player_movement.pitch_scale = pitch_scale

func stop_sfx() -> void:
	if sfx_files["walk"]: 
		sfx_player_movement.stop()
	sfx_is_playing = false

func get_sfx_duration(sfx_name:String):
	var sfx_path = sfx_files.get(sfx_name, "")
	if sfx_path != "":
		sfx_player_movement.stream = load(sfx_path)
		var sfx_duration = sfx_player_movement.stream.get_length()
		return sfx_duration

func _on_sfx_player_movement_finished() -> void:
	sfx_is_playing = false

func _on_sfx_player_button_finished() -> void:
	sfx_is_playing = false
