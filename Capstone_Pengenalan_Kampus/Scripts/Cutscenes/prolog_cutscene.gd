extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var path_follow_player: PathFollow2D = $PlayerPath2D/PathFollow2D
@onready var player_animated: AnimatedSprite2D = $PlayerPath2D/PathFollow2D/PlayerAnimated


#Panitia karakter
@onready var path_follow_panitia: PathFollow2D = $PanitiaPath2D/PathFollow2D
@onready var panitia: AnimatedSprite2D = $PanitiaPath2D/PathFollow2D/AnimatedSprite2D


#Parent Node
@onready var camera = $"../../Y_sort/Karakter/Player/Camera2D"
@onready var player: CharacterBody2D = $"../../Y_sort/Karakter/Player"
@onready var parent_animation_player: AnimationPlayer = $"../Transition/AnimationPlayer"


@export var speed = 0.2
var switch_dialog = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if camera and player:
		camera.enabled = false
		player.hide()
	run_dialog('Prolog')
	Dialogic.signal_event.connect(_on_dialogic_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	walk(delta)
	
func walk(delta):
	if path_follow_player.progress_ratio == 1.0:
		player_animated.play('idleU')
		path_follow_player.progress_ratio += 0
		walk_panitia(delta)
	else:
		player_animated.play('walkU')
		path_follow_player.progress_ratio += delta * speed

func walk_panitia(delta):
	if path_follow_panitia.progress_ratio == 1.0:
		panitia.play('idleU')
		path_follow_panitia.progress_ratio += delta * 0
	else:
		if Dialogic.VAR.TurnDialog:
			panitia.play('idleU')
			path_follow_panitia.progress_ratio += delta * speed
			Dialogic.VAR.TurnDialogCharacter = 'NPC_Entrance'

func run_dialog(dialog_string:String):
	Global.is_dialog = true
	Global.is_joystick= false
	Dialogic.start(dialog_string)

func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		animation_player.play('fadein')
	elif argument =="dialog_finished":
		animation_player.play('fadeout')
		await animation_player.animation_finished
		Global.is_dialog = false
		if camera and player:
			camera.enabled = true
			player.show()
		queue_free()
