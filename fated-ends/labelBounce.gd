extends Label  # Or Control, depending on your setup

@export var glitch_amount: float = 1.0  # Max distance for the glitch effect
@export var glitch_speed: float = 0.01  # Time interval for each glitch update

var original_position: Vector2
var glitch_timer: float = 0.0

func _ready():
	original_position = position  # Save the starting position

func _process(delta: float):
	glitch_timer += delta
	if glitch_timer >= glitch_speed:
		glitch_timer = 0.0
		# Apply random offset to simulate glitch
		var offset_x = randf_range(-glitch_amount, glitch_amount)
		var offset_y = randf_range(-glitch_amount, glitch_amount)
		position = original_position + Vector2(offset_x, offset_y)
