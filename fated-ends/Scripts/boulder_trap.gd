extends RigidBody3D

signal player_death
var moving:bool = false
var openDoor: bool = false
signal openDoorSignal(door_id: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 50
	add_to_group("trap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		$MeshInstance3D.rotate_z(7*delta)
		$"..".progress += 7*delta
		if $"..".progress_ratio >= 0.9:
			queue_free()
		if not openDoor and $"..".progress_ratio >= 0.7:
			openDoor = true
			emit_signal("openDoorSignal", 3)
			
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		emit_signal("player_death")
		print("test 123 du bist tot")


func _on_area_3d_body_entered(body: Node3D) -> void:
	$AudioStreamPlayer3D.play()
	moving = true
	pass # Replace with function body.
