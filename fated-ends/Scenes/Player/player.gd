extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 0.05

var playerhealth = 100

@onready var cam = $Camera3D

var CamRotation = Vector2(0,0)
var MouseSens = 0.001

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
			
	move_and_slide()
	

func damage():
	playerhealth -= 10
	if playerhealth <=0:
		pass
		#queue_free()


func _on_ui_shooting() -> void:
	pass # Replace with function body.
