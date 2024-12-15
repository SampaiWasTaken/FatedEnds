extends Area3D

var doorID = 4
@onready var spawnPoint = $newSpawnPoint

signal closeDoor(id:int)
signal setSpawnPoint(spawnPoint:Vector3, player_respawn_rotation:Vector3)
var closedDoor = false

func _on_body_entered(body: Node3D) -> void:
	if not closedDoor:
		emit_signal("closeDoor", doorID)
		emit_signal("setSpawnPoint", spawnPoint.global_position, spawnPoint.rotation)
		closedDoor = true
	pass # Replace with function body.
