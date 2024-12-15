extends RayCast3D

var interacting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var test = 0
@onready var interactlabel = $InteractLabel
func _process(delta: float) -> void:
	if is_colliding():
		var detected = get_collider()
		if detected is Interactable:
			interactlabel.text= detected.get_prompt()
			if Input.is_action_just_pressed(detected.promt_action) and not interacting:
				interacting = true
				detected.interact(owner)
				$"../../AnimationPlayer".play(detected.animation_action)
		else:
			interactlabel.text= ""
	else:
		interactlabel.text= ""
	pass




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	interacting = false
	pass # Replace with function body.
