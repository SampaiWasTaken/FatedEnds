extends Area3D

signal player_death
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_monitoring(true)
	add_to_group("trap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	print("trap sees", body)
	if body.is_in_group("player"):
		$"../AudioStreamPlayer".play()
		emit_signal("player_death")
		print("test 123 du bist tot")
