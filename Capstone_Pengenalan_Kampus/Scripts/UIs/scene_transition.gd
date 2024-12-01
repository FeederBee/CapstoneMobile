extends Node2D

@onready var transition = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global_variable.scene_transition == 'fade_out' :
		transition.play("fade_out")
	elif global_variable.scene_transition == 'fade_in':
		transition.play("fade_in")
