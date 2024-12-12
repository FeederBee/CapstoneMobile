extends Node

@export var default_spawnx:float
@export var default_spawny:float

@onready var parent = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_player():
	if SaveManager.load_data('current_map') == Global.current_map:
		var x = SaveManager.load_data("player_x_position") 
		var y = SaveManager.load_data("player_y_position") 
		parent.player.global_position = Vector2(x, y)

	else :
		if Global.spawn_position == Vector2.ZERO :
			parent.player.global_position = Vector2(default_spawnx, default_spawny)
		else:
			parent.player.global_position = Global.spawn_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
