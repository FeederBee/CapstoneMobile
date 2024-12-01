extends TileMapLayer


var transp = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func tree():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if global_variable.blur:
	modulate = Color(1, 1, 1)  # Blue
