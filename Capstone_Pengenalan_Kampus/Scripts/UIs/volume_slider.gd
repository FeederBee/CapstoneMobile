extends HSlider

@export var bus_name:String
@export var min_volume:float
@export var max_volume:float

var bus_index:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var music_vol_data = SaveManager.load_data("music_volume")
	var sfx_vol_data = SaveManager.load_data("sfx_volume")
	
	bus_index = AudioServer.get_bus_index(bus_name)
	if bus_name == 'music':
		print("bus_index", bus_index)
		if music_vol_data!=null:
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(music_vol_data))
		else:
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(AudioManager.music_volume))
	if bus_name == 'sfx':
		print("bus_index", bus_index)
		if sfx_vol_data!=null:
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(sfx_vol_data))
		else:
			AudioServer.set_bus_volume_db(bus_index, linear_to_db(AudioManager.sfx_volume))
	#value_changed.connect(_on_value_changed)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#var music_vol_data = SaveManager.load_data("music_volume")
	#var sfx_vol_data = SaveManager.load_data("sfx_volume")
	#
	#print("music_volume", music_vol_data)
	#print("sfx_volume", sfx_vol_data)
	pass
	

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	if bus_name == 'music':
		SaveManager.save({
			"music_volume" : value
		})
		if SaveManager.load_data("music_volume"):
			AudioManager.music_volume = SaveManager.load_data("music_volume")
		else : 
			AudioManager.music_volume = value
	elif bus_name == 'sfx':
		SaveManager.save({
			"sfx_volume" : value
		})
		if SaveManager.load_data("sfx_volume"):
			AudioManager.music_volume = SaveManager.load_data("sfx_volume")
		else : 
			AudioManager.music_volume = value
		
	
