extends Node3D
class_name RandomTarget3D

@export var MinRadius : float  = 1.0
@export var MaxRadius : float  = 10.0
@export var MaxAngleRange : int = -120
@export var MinAngleRange : int = 120

var target_arm: SpringArm3D
var target: Marker3D

func _ready() -> void:
	target_arm = SpringArm3D.new()
	target = Marker3D.new()
	target_arm.add_child(target)
	add_child(target_arm)	

func GetNextPoint() -> Vector3:
	randomize()
	var angle = deg_to_rad(randi_range(MinAngleRange, MaxAngleRange))
	var distance = randf_range(MinRadius , MaxRadius)
	rotation.y = angle
	target_arm.spring_length = distance
	return target.global_position
