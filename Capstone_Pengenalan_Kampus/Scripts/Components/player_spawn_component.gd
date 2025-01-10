extends Node

@export var default_spawnx:float
@export var default_spawny:float

@onready var parent = get_parent().get_parent()
#@onready var prolog_node: Node2D = $"../../PrologCutscene"
@onready var player: CharacterBody2D = $"../../Y_sort/Karakter/Player"

#
var spawn_coord = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_player():
	if SaveManager.load_data('current_map') == Global.current_map:
		var x = SaveManager.load_data("player_x_position") 
		var y = SaveManager.load_data("player_y_position") 
		player.global_position = Vector2(x, y)
		return
	
	if Global.spawn_position == Vector2.ZERO:
		return
	elif Global.spawn_position != Vector2.ZERO:
		player.global_position = Global.spawn_position
		return

#func prolog_cutscene_spawn_player():
	#if prolog_node:
		#player.global_position = prolog_node.get_player_position()

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(Vector2.ZERO)
	pass
