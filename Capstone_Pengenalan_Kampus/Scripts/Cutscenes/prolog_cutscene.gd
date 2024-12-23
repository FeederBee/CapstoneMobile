extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

#PlayerCharacter
@onready var player_animated: AnimatedSprite2D = $Player/PlayerAnimated
@onready var prolog_player: CharacterBody2D = $Player
@onready var player_spawn_component: Node = $"../Components/PlayerSpawnComponent"

#NPCkarakter
@onready var npc_prolog:CharacterBody2D = $NPC_Prolog
@onready var npc_animated: AnimatedSprite2D = $NPC_Prolog/AnimatedSprite2D

#Parent Node
@onready var camera = $"../Y_sort/Karakter/Player/Camera2D"
@onready var player: CharacterBody2D = $"../Y_sort/Karakter/Player"
@onready var parent_animation_player: AnimationPlayer = $"../Transition/AnimationPlayer"

##Set speed untuk Karakter
@export var speed = 100
@export var prolog_player_post = Vector2.ZERO

var dialog_finished = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SaveManager.load_data('timestamp'):
		queue_free()
		return

	if camera and player:
		camera.enabled = false
		player.hide()
	run_dialog('Prolog')
	Dialogic.signal_event.connect(_on_dialogic_signal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if SaveManager.load_data('timestamp'):
		#queue_free()
		#return
		
	move_player()
	move_npc()
	print(prolog_player.position)

	
func get_player_position():
	print(prolog_player.position)
	return prolog_player.position

func move_npc():
	if (2227<= npc_prolog.position.y and npc_prolog.position.y <= 2232) and !dialog_finished:
		stop(npc_prolog, npc_animated, 'idleD')
		return
		
	if dialog_finished:
		await get_tree().create_timer(1).timeout
		walk_down(npc_prolog, npc_animated, 'idleD')
		return
	
	walk_down(npc_prolog, npc_animated, 'idleD')
	#
	
func move_player():
	#Gerakan Player
	if (2408 >= prolog_player.position.y and prolog_player.position.y >= 2400) and !Dialogic.VAR.WalkAway:
		Dialogic.VAR.TurnDialogCharacter = 'NPC_Entrance'
		stop(prolog_player, player_animated, 'idleU')
		return
	
	if (2260 >= prolog_player.position.y and prolog_player.position.y >= 2255) and !Dialogic.VAR.WalkAway:
		stop(prolog_player, player_animated, 'idleU')
		return
	
	if (2260 >= prolog_player.position.y and prolog_player.position.y >= 2255) and Dialogic.VAR.WalkAway:
		if prolog_player.position.x <= 1800:
			stop(prolog_player, player_animated, 'idleR')
			return
			
		walk_left(prolog_player, player_animated)
		return
	
	walk_up(prolog_player, player_animated)
	
	
func walk_up(character_name, animation_name, anim_position:String = 'walkU'):
	animation_name.play(anim_position)
	if character_name is CharacterBody2D:
		character_name.velocity = Vector2(roundf(0), roundf(-speed))
		character_name.move_and_slide()
	
func walk_down(character_name, animation_name, anim_position:String = 'walkD' ):
	animation_name.play(anim_position)
	if character_name is CharacterBody2D:
		character_name.velocity = Vector2(round(0), round(+speed))
		character_name.move_and_slide()
		
func walk_left(character_name, animation_name, anim_position:String = 'walkL'):
	animation_name.play(anim_position)
	if character_name is CharacterBody2D:
		character_name.velocity = Vector2(round(-speed), round(0))
		character_name.move_and_slide()
	

func stop(character_name, animation_name, anim_position:String):
	animation_name.play(anim_position)
	if character_name is CharacterBody2D:
		character_name.velocity = Vector2.ZERO
		character_name.move_and_slide()

func run_dialog(dialog_string:String):
	Global.is_dialog = true
	Global.is_joystick= false
	Dialogic.start(dialog_string)

func _on_dialogic_signal(argument:String):
	if argument == "entering_dialog":
		animation_player.play('fadein')
	elif argument =="dialog_finished":
		dialog_finished = true
		await get_tree().create_timer(4).timeout
		animation_player.play('fadeout')
		await animation_player.animation_finished
		Global.is_dialog = false
		if camera and player:
			player_spawn_component.spawn_player()
			camera.enabled = true
			player.show()
		queue_free()
