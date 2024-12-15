extends Node

@export var text_label: RichTextLabel
@export var reveal_speed: float = 0.07
@export var game_scene: PackedScene # Reference to the game scene
var mainScene
var full_text: String = """
Gasping for air, trembling, and drenched in blood, you stumble to your feet in the aftermath of the battle. Against all odds, you survived the rogue mage’s last stand.
Your companions weren’t so [color=red]fortunate[/color].

A shadowed unease grips your soul, as if you’re a pawn in a game whose rules have been broken.

You were [color=red]meant[/color] to die here.

In a moment of desperate resolve, you invoked a forbidden rite—not to claim victory, but to endure. You gave up the finality of death.
You remain untouched by death’s hand… for now.

Yet the silence is deceptive, and the world itself seems to bend, unwilling to let you escape the [color=red]reckoning[/color] that’s long been overdue.















Use WASD to walk.

Hold Shift to sprint.

Press Space to jump.

Use E (e, this is super hard to read) to interact with objects.

Use Left Click to tempt [color=red]Fate[/color].

"""

var processed_text: Array = []
var visible_text: String = ""
var char_index: int = 0
var bruh
func _ready() -> void:
	mainScene = preload("res://main.tscn")
	bruh = mainScene.instantiate()
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().create_timer(0.1).timeout
	$"../AudioStreamPlayer".play()
	preprocess_bbcode()
	start_text_reveal()

func preprocess_bbcode() -> void:
	processed_text.clear()
	var i = 0
	while i < full_text.length():
		if full_text[i] == "[":
			var tag_end = full_text.find("]", i)
			if tag_end != -1:
				var tag = full_text.substr(i, tag_end - i + 1)
				if tag.find("[color=red]") != -1:
					processed_text.append([tag, false, true])
				else:
					processed_text.append([tag, false, false])
				i = tag_end + 1
				continue
		elif full_text[i] == "/" and full_text.substr(i, 2) == "[/":
			var tag_end = full_text.find("]", i)
			if tag_end != -1:
				var tag = full_text.substr(i, tag_end - i + 1)
				processed_text.append([tag, false, false])
				i = tag_end + 1
				continue
		else:
			processed_text.append([full_text[i], true, false])
		i += 1

func start_text_reveal():
	visible_text = ""
	char_index = 0
	text_label.text = visible_text
	_continue_reveal()

func _continue_reveal():
	if char_index < processed_text.size():
		var char_data = processed_text[char_index]
		if char_data[1]:
			visible_text += char_data[0]
		else:
			visible_text += char_data[0]
		text_label.text = visible_text
		char_index += 1
		await get_tree().create_timer(reveal_speed).timeout
		_continue_reveal()
	else:
		await get_tree().create_timer(3.0).timeout
		start_game()

func start_game():
	#var main_game_scene = game_scene.instantiate()
	get_tree().change_scene_to_packed(mainScene)
