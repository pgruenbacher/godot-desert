# this is an abstract class
var node;
var destination = Vector2()

var MAX_SPEED = 300
var MAX_FORCE = 0.02

var velocity = Vector2()

func get_map_position():
	return Vector2(node.translation.x, node.translation.z)

func get_new_velocity():
	var pos = get_map_position()
	var desired = (destination - pos).normalized() * MAX_SPEED
	var steer = desired - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return target_velocity
	
func _init(n):
	node = n
