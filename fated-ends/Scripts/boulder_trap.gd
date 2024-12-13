extends RigidBody3D

signal player_death
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 50
	add_to_group("trap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.name == "player":
		emit_signal("player_death")
		print("test 123 du bist tot")