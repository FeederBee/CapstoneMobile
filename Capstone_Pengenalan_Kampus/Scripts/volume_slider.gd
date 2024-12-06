extends HSlider

@export var bus_name:String

var bus_index:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(AudioManager.music_volume))
	value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_value_changed(value: float) -> void:
	# If you're using Godot 3, replace linear_to_db() with linear2db()
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	AudioManager.music_volume = value
	
