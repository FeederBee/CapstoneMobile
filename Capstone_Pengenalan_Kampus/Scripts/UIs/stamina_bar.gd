extends ProgressBar

@onready var reduce_stamina_bar: ProgressBar = $ReduceStaminaBar
@onready var timer: Timer = $Timer

var stamina = 0 : set = _set_stamina #Setters

func init_stamina(_stamina):
	max_value = _stamina
	stamina = _stamina
	value = stamina
	reduce_stamina_bar.max_value = stamina
	reduce_stamina_bar.value = stamina
	

func _set_stamina(new_stamina):
	var prev_stamina = stamina
	stamina = min(max_value, new_stamina)
	value = stamina
	
	if stamina <= 0 : 
		hide()
	
	if stamina < prev_stamina: 
		timer.start()
	else : 
		reduce_stamina_bar.value = stamina

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
