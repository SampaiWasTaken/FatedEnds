extends Node

@export var timer_duration: float 
@onready var timer: float = timer_duration  
@onready var timer_label: Label  
var playingAudio = false
var played = false

func _ready():
	timer_label = $"../CanvasLayer/DeathTimerLabel"  
	$"../AudioPlayers/BellPlayer".connect("finished", audio_finished)
	timer_label.text = str(timer_duration)

func _process(delta):
	timer -= delta
	timer_label.text = "Time Remaining: " + str(int(timer))
	
	if timer <= 10:
		if not playingAudio and not played:
			playingAudio = true
			played = true
			$"../AudioPlayers/BellPlayer".volume_db = -15
			$"../AudioPlayers/BellPlayer".play()
		timer_label.set("theme_override_colors/font_color", Color.RED) 
	else:
		timer_label.set("theme_override_colors/font_color", Color.WHITE) 
	
	if timer <= 0:
		trigger_fated_death()
func audio_finished():
	playingAudio = false
	
	
func trigger_fated_death():
	$"../CanvasLayer/Fated_Death".show()
	await get_tree().create_timer(5.0).timeout
	get_tree().reload_current_scene()
