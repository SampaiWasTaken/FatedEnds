extends Node

@export var player: CharacterBody3D  
@export var corpse_scene: PackedScene  

func _ready() -> void:
	for trap in get_tree().get_nodes_in_group("trap"):
		trap.connect("player_death", player_death_by_trap)


func _process(delta: float) -> void:
	if player.position.y <= -20:
		player_death_by_trap()

func player_death_by_trap():
	$"../AudioPlayers/DeathAudioPlayer".play()
	$"../CanvasLayer/CanvasAnimPlayer".play("fade_black")
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
	player.rotation = Vector3.ZERO
	player.transform.origin = Vector3(0, 0, 0)  
