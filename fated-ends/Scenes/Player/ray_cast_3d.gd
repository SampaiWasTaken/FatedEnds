extends RayCast3D


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
			if Input.is_action_just_pressed(detected.promt_action):
				detected.interact(owner)
		else:
			interactlabel.text= ""
	else:
		interactlabel.text= ""
	pass
