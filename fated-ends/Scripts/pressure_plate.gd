extends MeshInstance3D

@export var plate_activated: bool = false  
@export var plate_nr: int
signal pressure_plate_activated(door_id: int)
signal pressure_plate_deactivated(door_id: int)

func _ready() -> void:
	add_to_group("plates")

# Function to handle plate activation
func activate_plate() -> void:
	emit_signal("pressure_plate_activated", plate_nr)

# Function to handle plate deactivation
func deactivate_plate() -> void:
	emit_signal("pressure_plate_deactivated", plate_nr)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		plate_activated = false
		deactivate_plate() 


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("plate pressed")
	if body.is_in_group("player"):  
		plate_activated = true
		activate_plate()  
