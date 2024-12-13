extends Node

@export var timer_duration: float # Set your timer duration here
@onready var timer: float = timer_duration  # Timer starts at the set duration
@onready var timer_label: Label  # The label that will display the timer
@onready var audioPlayer: AudioStreamPlayer = $"../AudioStreamPlayer"
# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the Label node. Make sure to drag and drop your Label into this variable in the Inspector
	timer_label = $"../CanvasLayer/DeathTimerLabel"  # Adjust the path if necessary
	
	# Optionally set label's initial text
	timer_label.text = str(timer_duration)

func _process(delta):
	# Decrease the timer by the delta time (the frame's time)
	timer -= delta
	
	# Update the label with the remaining time, formatted as seconds
	timer_label.text = "Time Remaining: " + str(int(timer))
	
	if timer <= 10:
		audioPlayer.play()
		timer_label.set("theme_override_colors/font_color", Color.RED) # Red color for low time
	else:
		timer_label.set("theme_override_colors/font_color", Color.WHITE) # Reset to default color
	# Check if the timer has run out
	if timer <= 0:
		trigger_fated_death()

func trigger_fated_death():
	# Handle the fated death (e.g., reset the scene, trigger animations, etc.)
	print("Fate claims you.")
	get_tree().reload_current_scene()
