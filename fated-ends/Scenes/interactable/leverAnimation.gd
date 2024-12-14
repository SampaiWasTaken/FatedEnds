extends AnimationPlayer

var pulled = false

func _on_lever_interacted(body: Variant) -> void:
	
	if not pulled:
		play("pull")
		pulled = true
	else:
		play_backwards("pull")
		pulled = false
	print(pulled)
	pass # Replace with function body.
