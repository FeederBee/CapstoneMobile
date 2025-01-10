extends Node2D

@onready var player: CharacterBody2D = $PlayerCutscene
@onready var npc: CharacterBody2D = $NPC
@onready var animated_sprite_player: AnimatedSprite2D = $PlayerCutscene/AnimatedSprite2D
@onready var animated_sprite_npc: AnimatedSprite2D = $NPC/AnimatedSprite2D
@onready var camera: Camera2D = $PlayerCutscene/Camera2D
@onready var end_timer: Timer = $EndTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Variabel untuk mengatur kecepatan dan target jarak
@export var player_speed: float = 100
@export var npc_speed: float = 80

# Target jarak (pixel)
@export var player_target_distance: float = 330
@export var npc_target_distance: float = 180

# Preload scene
@onready var credits = preload("res://Scenes/Cutscenes/EndingCredits.tscn")

# Status untuk mengatur fase gerakan
var player_movement_done: bool = false
var npc_movement_done: bool = true

# Variabel untuk menghitung jarak yang sudah ditempuh
var player_distance_traveled: float = 0
var npc_distance_traveled: float = 0

#Variable kondisi
var cutscene_done:bool = false

func _ready() -> void:
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	cinematic()
	run_dialog('Ending')

func _process(delta: float) -> void:
	if cutscene_done:
		if not player_movement_done:
			move_player(delta)
			
		# Jika Player selesai dan NPC belum selesai bergerak
		elif not npc_movement_done:
			move_npc(delta, Vector2.RIGHT, 30)
			await get_tree().create_timer(1).timeout
			player_movement_done = false
			end_timer.start()
		else:
			return
	else: 
		# Jika Player belum selesai bergerak
		if not player_movement_done:
			move_player(delta)
		# Jika Player selesai dan NPC belum selesai bergerak
		elif not npc_movement_done:
			move_npc(delta, Vector2.UP)
		# Jika NPC selesai bergerak, panggil dialog
		else:
			return
			
	

func cinematic():
	animation_player.play('fade_in')

func run_dialog(dialog_string:String):
	Dialogic.start(dialog_string)

# Fungsi untuk menggerakkan Player
func move_player(delta: float,  direction:Vector2 = Vector2.DOWN) -> void:
	var movement = direction * player_speed * delta
	player.global_position += movement
	player_distance_traveled += movement.length()
	
	if player_distance_traveled >= player_target_distance:
		player_movement_done = true
		_play_idle_animation(animated_sprite_player, direction)
		return
	
	_play_walk_animation(animated_sprite_player, direction)

# Fungsi untuk menggerakkan NPC
func move_npc(delta: float, direction:Vector2, distance:float = npc_target_distance) -> void:
	var movement = direction * npc_speed * delta
	npc.global_position += movement
	npc_distance_traveled += movement.length()

	if npc_distance_traveled >= distance:
		npc_movement_done = true
		if distance == 30:
			direction = Vector2.LEFT
			
		_play_idle_animation(animated_sprite_npc, direction)
		return
	
	_play_walk_animation(animated_sprite_npc, direction)

#Animasi
func _play_walk_animation(animated:AnimatedSprite2D , direction:Vector2):
	var animated_sprite = animated
	if direction == Vector2.LEFT:
		animated_sprite.play("walkL")
	elif direction == Vector2.RIGHT:
		animated_sprite.play("walkR")
	elif direction == Vector2.UP:
		animated_sprite.play("walkU")
	elif direction == Vector2.DOWN:
		animated_sprite.play("walkD")

func _play_idle_animation(animated:AnimatedSprite2D , direction:Vector2):
	var animated_sprite = animated
	if direction == Vector2.LEFT:
		animated_sprite.play("idleL")
	elif direction == Vector2.RIGHT:
		animated_sprite.play("idleR")
	elif direction == Vector2.UP:
		animated_sprite.play("idleU")
	elif direction == Vector2.DOWN:
		animated_sprite.play("idleD")


## Fungsi untuk memanggil dialog (placeholder)
#func trigger_dialog() -> void:
	## Abaikan implementasi dialog karena sudah dibuat
	#print("Memulai dialog...")
	## Matikan proses agar tidak terus dipanggil
	#set_process(false)

func _on_dialogic_signal(argument):
	if argument == 'npc_masuk':
		npc_movement_done = false
	elif argument == 'dialog_finished':
		npc_distance_traveled = 0
		player_distance_traveled = 0
		npc_movement_done = false
		cutscene_done = true



func _on_end_timer_timeout() -> void:
	animation_player.play("fade_out_end")
	await get_tree().create_timer(1).timeout
	Global.change_map("res://Scenes/Cutscenes/EndingCredits.tscn", "EndingCutscene/AnimationPlayer")
	#get_tree().change_scene_to_file("res://Scenes/Cutscenes/EndingCredits.tscn")
	#get_tree().change_scene_to_packed(credits)
	
