extends CharacterBody3D

@export var wobble_amount: float = 0.1
@export var wobble_speed: float = 10.0 
var wobble_timer: float = 0.0  
var walking = false

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 0.05

var playerhealth = 100

@onready var cam = $Camera3D
@onready var cam_init_pos = cam.position.y

var CamRotation = Vector2(0,0)
var MouseSens = 0.007

func _ready() -> void:
	cam.current = true
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative*MouseSens
		CameraLook(MouseEvent)

# https://www.youtube.com/watch?v=O77xgrp5nOY used this tutorial for mouse movement
func CameraLook(Movement: Vector2):
	CamRotation += Movement
	CamRotation.y = clamp(CamRotation.y, -1.5, 1.2)
	
	transform.basis = Basis()
	cam.transform.basis = Basis()
	
	rotate_object_local(Vector3(0, 1, 0), -CamRotation.x)#first rotate y
	cam.rotate_object_local(Vector3(1,0,0), -CamRotation.y)#then rotate x
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	#if Input.is_action_just_pressed("quit"):
	#	$"../".exit_game(name.to_int())
	#	get_tree().quit()


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#if Input.is_action_pressed("ui_left"):
		#self.rotate_y(TURN_SPEED)
		#self.rotation.y = self.rotation.y + TURN_SPEED
	#if Input.is_action_pressed("ui_right"):
		#self.rotation.y = self.rotation.y - TURN_SPEED
		#self.rotate_y(-TURN_SPEED)
	_push_away_rigid_bodies()
	move_and_slide()
	

func damage():
	playerhealth -= 10
	if playerhealth <=0:
		pass
		#queue_free()
		
# CC0/public domain/use for whatever you want no need to credit
# Call this function directly before move_and_slide() on your CharacterBody3D script
func _push_away_rigid_bodies():
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			var push_dir = -c.get_normal()
			# How much velocity the object needs to increase to match player velocity in the push direction
			var velocity_diff_in_push_dir = self.velocity.dot(push_dir) - c.get_collider().linear_velocity.dot(push_dir)
			# Only count velocity towards push dir, away from character
			velocity_diff_in_push_dir = max(0., velocity_diff_in_push_dir)
			# Objects with more mass than us should be harder to push. But doesn't really make sense to push faster than we are going
			const MY_APPROX_MASS_KG = 80.0
			var mass_ratio = min(1., MY_APPROX_MASS_KG / c.get_collider().mass)
			# Optional add: Don't push object at all if it's 4x heavier or more
			if mass_ratio < 0.25:
				continue
			# Don't push object from above/below
			push_dir.y = 0
			# 5.0 is a magic number, adjust to your needs
			var push_force = mass_ratio * 5.0
			c.get_collider().apply_impulse(push_dir * velocity_diff_in_push_dir * push_force, c.get_position() - c.get_collider().global_position)


func _on_ui_shooting() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if is_walking():  # Ensure wobble only happens when moving
		wobble_timer += delta * wobble_speed
		var wobble_offset = sin(wobble_timer) * wobble_amount
		cam.position.y = cam_init_pos + wobble_offset
	else:
		wobble_timer = 0.0  # Reset wobble when stationary
		cam.position.y = cam_init_pos
		
func is_walking() -> bool:
	return !velocity.is_equal_approx(Vector3.ZERO)  # Example check for movement
