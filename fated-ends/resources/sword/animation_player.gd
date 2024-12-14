extends AnimationPlayer





func _on_interactable_sword_interacted(body: Variant) -> void:
	play("picked_up")
	pass # Replace with function body.


func _on_animation_finished(anim_name: StringName) -> void:
	queue_free()
	pass # Replace with function body.
