class_name Interactable
extends StaticBody3D

signal interacted(body)

@export var promt_message = "Interact"
@export var promt_action = "interact"

func get_prompt():
	var key_name = ""
	for action in InputMap.action_get_events(promt_action):
		if action is InputEventKey:
			key_name = action.as_text_physical_keycode()
	return promt_message + "\n[" + key_name + "]"

func interact(body):
	emit_signal("interacted",body)
