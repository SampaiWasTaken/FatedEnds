extends Node

@export var player: CharacterBody3D  # Reference to the player node
@export var corpse_scene: PackedScene  # Reference to the corpse scene

func _ready() -> void:
	for trap in get_tree().get_nodes_in_group("trap"):
		print(trap)
		trap.connect("player_death", player_death_by_trap)

# Called when the player dies
func player_death_by_trap():
	print("triggered death")
	spawn_corpse()
	reset_player_position()  # Reset player position but leave corpse behind

func fated_death():
	get_tree().reload_current_scene()

# Spawning the corpse at the player's position
func spawn_corpse():
	var corpse_instance = corpse_scene.instantiate()
	corpse_instance.transform.origin = player.transform.origin
	corpse_instance.rotation = player.rotation
	get_tree().current_scene.add_child.call_deferred(corpse_instance)

# Reset the player's position after death
func reset_player_position():
	player.transform.origin = Vector3(0, 0, 0)  # Reset to start position
	 # Reset rotation
