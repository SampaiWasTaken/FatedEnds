extends Label

@export var full_text: String  # The full text to reveal
@export var reveal_speed: float = 0.05  # Delay between characters
var current_index = 0

func _ready():
	text = ""  # Start empty
	_reveal_text()

func _reveal_text():
	if current_index < full_text.length():
		text += full_text[current_index]
		current_index += 1
		await get_tree().create_timer(reveal_speed).timeout
		_reveal_text()
