extends Node3D
@export var door_id: int
var open = false
var playingAudio = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for plate in get_tree().get_nodes_in_group("plates"):
		print(plate)
		plate.connect("pressure_plate_activated", door_activated)
		plate.connect("pressure_plate_deactivated", door_deactivated)
	$AudioStreamPlayer3D.pitch_scale = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if open:
		$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled = true
	else:
		$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled = false
	pass


func door_activated(door_id: int):
	if door_id == self.door_id:
		if not playingAudio:
			$AudioStreamPlayer3D.play()
		open = true
		$AnimationPlayer.play("open")
		set_deferred("$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled", true)

func door_destroy(door_id: int):
	if door_id == self.door_id:
		if not playingAudio:
			$AudioStreamPlayer3D.play()
		open = true
		$AnimationPlayer.play("destroy")
		set_deferred("$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled", true)
	
func door_deactivated(door_id: int):
	if door_id == self.door_id:
		if not playingAudio:
			$AudioStreamPlayer3D.play()
		open=false
		$AnimationPlayer.play("close")
		set_deferred("$Armature/Skeleton3D/WoodenDoor/Area3D/CollisionShape3D.disabled", false)


func _on_audio_stream_player_3d_finished() -> void:
	playingAudio = false
