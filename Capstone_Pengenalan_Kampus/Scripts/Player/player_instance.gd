extends CharacterBody2D

@export var speed: float = 100
@onready var animated_sprite := $AnimatedSprite2D
@onready var detection_area := $Area2D
@onready var states := $States  # Node untuk state machine

var last_direction := Vector2.DOWN
var current_state = null

func _ready():
	change_state("IdleState")  # Set state awal ke Idle

func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_process_state(delta)

# Fungsi untuk mengganti state dan mengaktifkan node state yang relevan
func change_state(new_state_name: String):
	if current_state:
		current_state.exit_state()
	
	for state in states.get_children():
		state.set_process(false)
		state.set_physics_process(false)

	current_state = states.get_node(new_state_name)
	current_state.set_process(true)
	current_state.set_physics_process(true)
	current_state.enter_state()
