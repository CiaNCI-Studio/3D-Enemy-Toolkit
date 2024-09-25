extends NavigationAgent3D
class_name FollowTarget3D

signal ReachedTarget(target : Node3D)

@export var Speed : float = 5.0
@export var TurnSpeed : float = 0.3
@export var ReachTargetMinDistance : float = 1.3

var target : Node3D
var isTargetSet : bool = false
var targetPosition : Vector3 = Vector3.ZERO
var lastTargetPosition : Vector3 = Vector3.ZERO
var fixedTarget : bool = false

@onready var parent = get_parent() as CharacterBody3D

func _ready() -> void:
	velocity_computed.connect(_on_velocity_computed)

func _process(delta: float) -> void:
	if fixedTarget:
		go_to_location(targetPosition)	
	elif target:
		go_to_location(target.global_position)
		if target and parent.global_position.distance_to(target.global_position) <= ReachTargetMinDistance:
			emit_signal("ReachedTarget", target)
	
	parent.move_and_slide()
	
func SetFixedTarget(newTarget : Vector3) -> void:
	target = null
	targetPosition = newTarget
	fixedTarget = true
	isTargetSet = true

func SetTarget(newTarget : Node3D) -> void:
	target = newTarget
	targetPosition = Vector3.ZERO
	fixedTarget = false
	isTargetSet = true

func ClearTarget() -> void:
	target = null
	targetPosition = Vector3.ZERO
	isTargetSet = false
	
func go_to_location(targetPosition : Vector3):
	if not isTargetSet or lastTargetPosition != targetPosition:
		set_target_position(targetPosition)
		lastTargetPosition = targetPosition
		isTargetSet = true
		
	var lookDir = atan2(-parent.velocity.x, -parent.velocity.z)
	parent.rotation.y = lerp_angle(parent.rotation.y, lookDir, TurnSpeed)
	
	if is_navigation_finished():
		isTargetSet = false
		return
	
	var nextPathPosition = get_next_path_position()
	var currentEnemyPosition = parent.global_position
	var newVelocity = (nextPathPosition - currentEnemyPosition).normalized() * Speed
	
	if avoidance_enabled:
		set_velocity(newVelocity.move_toward(newVelocity, 0.25))
	else:
		parent.velocity = newVelocity.move_toward(newVelocity, 0.25)

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	parent.velocity = parent.velocity.move_toward(safe_velocity, 0.25)
