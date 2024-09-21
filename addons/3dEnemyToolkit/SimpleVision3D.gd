extends Node3D
class_name SimpleVision3D

signal GetSight(body : Node3D)
signal LostSight

@export var Enabled : bool = true
@export var LookUpGroup : String = "player"

@export_category("Vision Area")
@export var Distance : float = 50.0
@export var BaseWidth : float = 10.0
@export var EndWidth : float = 30.0
@export var BaseHeight : float = 5.0
@export var EndHeight : float = 5.0
@export var BaseConeSize : float = 1.0
@export var VisionArea : CollisionShape3D

var vision : Area3D
var target : Node3D

func _ready() -> void:
	vision = Area3D.new()
	if not VisionArea:
		VisionArea = CollisionShape3D.new()
		VisionArea.shape = __BuildVisionShape()	
	vision.add_child(VisionArea)
	add_child(vision)

func _process(delta: float) -> void:
	if not Enabled:
		return
		
	if target:
		if not CheckSight(target):
			target = null
			emit_signal("LostSight")
	else:
		CheckOverlaping()

func CheckSight(sightTarget : Node3D) -> bool:
	var space = get_world_3d().direct_space_state
	var ignore : Array[RID] = []	
	var query = PhysicsRayQueryParameters3D.create(global_position, sightTarget.global_position)
	var collision = space.intersect_ray(query)
	if collision:
		if collision.collider == sightTarget:
			return true
	return false

func CheckOverlaping():
	var overlapingBodies = vision.get_overlapping_bodies()
	var targetOverlap = overlapingBodies.filter(func(item : Node3D) : return item.is_in_group(LookUpGroup))
	if len(targetOverlap) > 0:
		if CheckSight(targetOverlap[0]):
			target = targetOverlap[0]
			emit_signal("GetSight", target)

func __BuildVisionShape() -> ConvexPolygonShape3D:
	var result = ConvexPolygonShape3D.new()
	var points = PackedVector3Array()
	points.append(Vector3(0, 0, 0))
	points.append(Vector3(BaseHeight/2, 0, -BaseConeSize))
	points.append(Vector3(EndWidth/2, 0, -Distance))
	points.append(Vector3(-(BaseHeight/2), 0, -BaseConeSize))
	points.append(Vector3(-(EndWidth/2), 0, -Distance))
	points.append(Vector3(0, BaseHeight, 0))	
	points.append(Vector3(BaseHeight/2, BaseHeight, -BaseConeSize))
	points.append(Vector3(EndWidth/2, BaseHeight, -Distance))
	points.append(Vector3(-(BaseHeight/2), BaseHeight, -BaseConeSize))
	points.append(Vector3(-(EndWidth/2), BaseHeight, -Distance))	    
	result.points = points
	return result
	
