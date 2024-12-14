extends Node3D



func _ready() -> void:
	add_to_group("player")
	$AnimationPlayer.play("mixamo_com")
	$AnimationPlayer.seek(1.2)
	
	

func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$StaticBody3D/CollisionShape3D.disabled = false
