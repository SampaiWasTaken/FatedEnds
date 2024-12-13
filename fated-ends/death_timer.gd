extends Node

@export var time_limit: float = 30.0 # Set the initial timer duration
var time_remaining: float

@onready var timer_label = $TimerLabel

func _ready():
	time_remaining = time_limit
	$Timer.start(time_limit)

func _process(delta):
	time_remaining -= delta
	timer_label.text = str(floor(time_remaining))
	if time_remaining <= 0:
		trigger_death_event()

func trigger_death_event():
	# Add logic for death or reset
	print("You died!") 
