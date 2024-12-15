extends Node

@export var player: CharacterBody3D  
@export var corpse_scene: PackedScene  

var onEnter = "You realize that this is the end of the road for you. Do what must be done and pay the price for your defiance."

var storyBeats = ["It seems your feeble flesh clings to life still. Perhaps the rite was more powerful than you had envisioned.",
"Try as you might, you won't be claimed...",
"Not today, not any day. This is the punishment for your hubris.",
"Fate is a cruel mistress indeed."]

var randomizedStoryBeats = ["You're stuck here, forever.", 
"Your end is none at all.",
"The cycle binds you tighter with each step.",
"The room remains, and so do you.",
"Sacrifice is meaningless when there’s nothing left to lose.",
"The cake is a lie.",
"This punishment is the only certainty you have left.",
"Your actions echo, but the walls do not listen.",
"Another step, another fall, another eternity.",
"You are trapped within your own choices.",
"The room watches, unfeeling, as you crumble.",
"The light you seek does not exist here.",
"Your existence is a loop, unbroken and unbreakable.",
"This is all there is, this is all there will ever be.",
"The room will outlast you, and you will never leave.",
"You’ve cheated death, but now it cheats you.",
"You are a prisoner of your own defiance."
]
var respawnPoint:Vector3 = Vector3(0, 0, 0)
var player_respawn_rotation:Vector3 = Vector3.ZERO
var inFinalRoom:bool = false 

func _ready() -> void:
	for trap in get_tree().get_nodes_in_group("trap"):
		trap.connect("player_death", player_death_by_trap)


func _process(delta: float) -> void:
	if player.position.y <= -20:
		player_death_by_trap()

func player_death_by_trap():
	$"../AudioPlayers/DeathAudioPlayer".play()
	$"../CanvasLayer/CanvasAnimPlayer".play("fade_black")
	$"../TimerManager".timer -= 10
	spawn_corpse()
	reset_player_position()  

func fated_death():
	get_tree().reload_current_scene()


func spawn_corpse():
	var corpse_instance = corpse_scene.instantiate()
	corpse_instance.transform.origin = player.transform.origin
	corpse_instance.rotation = player.rotation
	get_tree().current_scene.add_child.call_deferred(corpse_instance)


func reset_player_position():
	player.resetAnimation()
	player.rotation = player_respawn_rotation
	player.transform.origin = respawnPoint

func finalRoomTrigger(newSpawnpoint:Vector3, newplayer_respawn_rotation:Vector3):
	respawnPoint = newSpawnpoint
	player_respawn_rotation = newplayer_respawn_rotation
	inFinalRoom = true
