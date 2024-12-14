extends Node3D
@export var door_id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for plate in get_tree().get_nodes_in_group("plates"):
		plate.connect("pressure_plate_activated", door_activated)
		plate.connect("pressure_plate_deactivated", door_deactivated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func door_activated(door_id: int):
	if door_id == self.door_id:
		$AnimationPlayer.play("open")
		set_deferred("$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled", true)
	
func door_deactivated(door_id: int):
	
	if door_id == self.door_id:
		$AnimationPlayer.play("close")
		set_deferred("$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled", false)
