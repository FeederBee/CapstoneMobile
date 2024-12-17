extends Node

@export var buff_speed : float = 400  # Kecepatan buff

@onready var animated_sprite = $"../AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("spin")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pick_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" :# Pastikan hanya player yang mendapat buff
		if $"..".name == "buff_speed": #buff speed
			$"../AnimatedSprite2D".hide()
			Global.apply_speed_buff(buff_speed, 10)
			queue_free()  # Hapus buff setelah diambil
