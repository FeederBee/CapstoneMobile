extends Node

@onready var player = $"../../Y_sort/Karakter/Player"
@onready var auto_save_timer: Timer = $AutoSaveTimer
@onready var info_timer: Timer = $InfoTimer
@onready var info: Label = $CanvasLayer/Info

func _ready() -> void:
	print(player)
	info.hide()
	await get_tree().create_timer(2).timeout
	if Global.auto_save_is:
		auto_save_timer.start()

#
func _process(_delta: float) -> void:
	if Global.is_change_map:
		auto_save_timer.stop()
		info_timer.stop()

func _on_auto_save_timer_timeout() -> void:
	info.text = "Auto   Saving. . ."
	info.show()
	if player:
		SaveManager.save({
			"timestamp" : Time.get_datetime_string_from_system(), # Tambahkan timestamp sebagai identitas
			"player_x_position": player.position.x,
			"player_y_position": player.position.y,
			"player_stamina": player.stamina,
			"current_map": Global.current_map,
		})
	else:
		print("Player belum diinisialisasi!")
	info_timer.start()

func _on_info_timer_timeout() -> void:
	info.text = "Saving   Succed!"
	await get_tree().create_timer(3).timeout
	info.hide()
	auto_save_timer.start()
