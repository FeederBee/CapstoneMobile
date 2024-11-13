extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_variable.change_map = true
	await get_tree().create_timer(0.3).timeout
	global_variable.change_map = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
