extends Node3D

@export var leverID: int
signal pressure_plate_activated(door_id: int)
signal pressure_plate_deactivated(door_id: int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("plates")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_lever_interacted(body: Variant) -> void:
	print($"../AnimationPlayer".pulled)
	if $"../AnimationPlayer".pulled:
		print("opening door")
		emit_signal("pressure_plate_activated", leverID)
	else:
		emit_signal("pressure_plate_deactivated", leverID)
