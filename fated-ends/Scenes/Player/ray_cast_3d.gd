extends RayCast3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var test = 0
@onready var interactlabel = $InteractLabel
func _process(delta: float) -> void:
	if is_colliding():
		#print("colliding"+str(test))
		interactlabel.text = str(get_collider())
		#test+=1
	else:
		interactlabel.text= ""
	pass
