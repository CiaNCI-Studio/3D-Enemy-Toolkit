extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TurnSpeed = 0.2


@onready var geometry: MeshInstance3D = $Geometry

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var lookDir = atan2(-velocity.x, -velocity.z)
	geometry.rotation.y = lerp_angle(geometry.rotation.y, lookDir, TurnSpeed)

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
