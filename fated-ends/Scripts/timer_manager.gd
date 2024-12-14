extends Node

@export var timer_duration: float 
@onready var timer: float = timer_duration  
@onready var timer_label: Label  
var playingAudio = false

func _ready():
	timer_label = $"../CanvasLayer/DeathTimerLabel"  
	$"../AudioStreamPlayer".connect("finished", audio_finished)
	timer_label.text = str(timer_duration)

func _process(delta):
	timer -= delta
	timer_label.text = "Time Remaining: " + str(int(timer))
	
	if timer <= 10:
		if not playingAudio:
			playingAudio = true
			$"../AudioStreamPlayer".volume_db = -15
			$"../AudioStreamPlayer".play()
		timer_label.set("theme_override_colors/font_color", Color.RED) 
	else:
		timer_label.set("theme_override_colors/font_color", Color.WHITE) 
	
	if timer <= 0:
		trigger_fated_death()
func audio_finished():
	playingAudio = false
	
	
func trigger_fated_death():
	$"../CanvasLayer/Fated_Death".show()
	print("Fate claims you.")
	await get_tree().create_timer(5.0).timeout
	get_tree().reload_current_scene()
