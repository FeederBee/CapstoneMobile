extends Node

@onready var player: CharacterBody2D = $"../Y_sort/Karakter/Player"
@onready var save_load_manager: Node = $"../../SaveLoadManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var parent = get_parent().get_parent()
	#posisi Spawn Karakter
	if save_load_manager.load('current_map') == Global.current_map:
		var x = save_load_manager.load("player_x_position") 
		var y = save_load_manager.load("player_y_position") 
		player.global_position = Vector2(x,y)
	else :
		player.global_position = Global.spawn_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
