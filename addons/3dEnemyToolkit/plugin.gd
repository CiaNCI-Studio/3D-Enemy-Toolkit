@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("FollowTarget3D", "NavigationAgent3D", preload("./FollowTarget.gd"), preload("./icons/FollowTarget3D.svg"))
	add_custom_type("RandomTarget3D", "Node3D", preload("./RandomTarget3D.gd"), preload("./icons/RandomMovement3D.svg"))
	add_custom_type("SimpleVision3D", "Node3D", preload("./SimpleVision3D.gd"), preload("./icons/Vision3D.svg"))


func _exit_tree() -> void:
	remove_custom_type("FollowTarget3D")
	remove_custom_type("RandomTarget3D")
	remove_custom_type("SimpleVision3D")
