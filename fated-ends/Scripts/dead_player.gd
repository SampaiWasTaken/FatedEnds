extends Node3D

func _ready() -> void:
	#rotate_y(180)
	add_to_group("corpse")
	$AnimationPlayer.play("mixamo_com")
	$AnimationPlayer.seek(1.2)
	$RigidBody3D.add_to_group("corpse")

func _process(delta: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$RigidBody3D/CollisionShape3D.disabled = false
	$RigidBody3D.freeze = false
	$RigidBody3D.force_update_transform()
	$RigidBody3D.move_and_collide(Vector3(0.1, 0, 0))
	$RigidBody3D.freeze = true
