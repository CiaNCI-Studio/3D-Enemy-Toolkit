# 3D-Enemy-Toolkit

3D Enemy Toolkit For Godot 4.3

Includes:
	
	* Follow Target 3D
	* Simple Vision 3D
	* Random Target 3D

See examples to see full implementation.	

Configurations:

* FollowTarget3D:
	* signal: ReachedTarget(target : Node3D) => If target was reached, uses ReachTargetMinDistance	
	* Speed : Movement Speed
	* TurnSpeed : Turn Speed
	* ReachTargetMinDistance : Distance to target to emit ReachedTarget signal

* SimpleVision3D:
	* signal GetSight(body : Node3D) => When Target it's seen 
	* signal LostSight => When Target it's lost 	
	* Enabled : If is enabled
	* LookUpGroup : Group to lookup
	* Distance : Vision distance
	* BaseWidth : Vision Shape Base Width
	* EndWidth : Vision Shape end Width
	* BaseHeight : Vision Shape Base Height
	* EndHeight : Vision Shape End Height
	* BaseConeSize : Vision Shape Base cone Size
	* VisionArea : optional CollisionShape3D with vision shape, if set ignores other shape configurations.

* RandomTarget3D:
	* MinRadius : Minimum radius for the target
	* MaxRadius : Maximum radius for the target
	* MaxAngleRange : Minimum angle range for the next target
	* MinAngleRange : Maximum angle range for the next target
	
Check out CiaNCI Chanel on YouTube for more: https://www.youtube.com/@CiaNCIStudio
