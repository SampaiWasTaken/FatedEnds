extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in self.get_children():
		child.add_to_group("trap")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
