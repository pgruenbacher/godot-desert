# this is an abstract class
var node;
var destination = Vector3()
var pts = Array()

var MAX_FORCE = 0.02

var velocity = Vector3()
var GRAVITY = -9.8
var ACCELERATION = 3
var DE_ACCELERATION = 5
var MAX_SPEED = 6
var MAX_FALL = 15
const UP = Vector3(0, 1, 0)

func get_map_position():
	return node.translation

func apply(delta):
	var pos = get_map_position()
	
	redraw_destination_lines(pts)
	
	var dir = (destination - pos)
	dir.y = 0
	dir = dir.normalized()
	velocity.y += delta * GRAVITY 
	var hv = velocity 
	hv.y = 0
	var new_pos = dir * MAX_SPEED 
	var accel = DE_ACCELERATION
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
	hv = hv.linear_interpolate(new_pos, accel*delta)
	velocity.x = hv.x 
	velocity.z = hv.z
	var slope_stop_min_vel = 0.05
	var max_slides = 4
	var floor_max_angle = PI / 2
	print("VEL", velocity)
	velocity = node.move_and_slide(velocity, UP)
	print("LEFTOVER", velocity)
	print("TRAN", node.translation)
	print("SLIDE COUNT", node.get_slide_count())
	print("COLL?", node.is_on_floor(), node.is_on_wall(), node.is_on_ceiling())
	return
	
	var desired_xz = destination - pos
	desired_xz.y = 0
	desired_xz = desired_xz.normalized() * MAX_SPEED
	#var desired3d = (destination - pos)
	#desired3d.y = 0
	#desired_xz = desired_xz.normalized() * MAX_SPEED
	#desired3d.y += delta * GRAVITY
	print("DESIRED", desired_xz)
	var steer = desired_xz - velocity
	print("STEER", steer)
	var target_velocity = desired_xz
	target_velocity.x = velocity.x + (steer.x * ACCELERATION)
	target_velocity.z = velocity.z + (steer.z * ACCELERATION)
	if node.is_on_floor():
		print("YES")
	#print("IS ON FLOOR", node.is_on_floor(), node.is_on_wall(), node.is_on_ceiling())
	#if not node.is_on_floor():
	target_velocity.y = velocity.y + delta * GRAVITY - 1
	target_velocity = truncatexz(target_velocity, MAX_SPEED)
	print ("TARGET", target_velocity)
	#var slope_stop_min_vel = 0.05
	#var max_slides = 4
	#var floor_max_angle = PI / 2
	#var leftover = node.move_and_slide(target_velocity, UP, slope_stop_min_vel, max_slides, floor_max_angle)
	# velocity = node.move_and_slide(target_velocity, UP)
	#redraw_destination_lines(pts)
	
func _init(n):
	node = n
	
	m.set_line_width(2)
	m.set_point_size(2)
	m.set_flag(SpatialMaterial.FLAG_USE_POINT_SIZE, true)
	m.albedo_color = Color(0.2, 0.8, 0.2)
	m.set_flag(SpatialMaterial.FLAG_UNSHADED, true)
	
	node.get_tree().get_root().call_deferred("add_child", im)
	
func truncatexz( vec, val = MAX_SPEED):
	if vec.length() > val:
		vec = vec.normalized() * val
	return vec
	

var im = ImmediateGeometry.new()
var m = SpatialMaterial.new()


func redraw_destination_lines(pts):
	var end_point = copy(destination)
	var start_point = copy(get_map_position())
	end_point.y += 1
	start_point.y += 0.2
	im.clear()
	im.set_material_override(m)
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	for i in len(pts) - 1:
		im.add_vertex(pts[i])
	#im.add_vertex(pts[i + 1])
	im.end()

func redraw_destination_line():
	var end_point = copy(destination)
	var start_point = copy(get_map_position())
	end_point.y += 1
	start_point.y += 0.2
	im.clear()
	im.set_material_override(m)
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	im.add_vertex(start_point)
	im.add_vertex(end_point)
	im.end()
	
func copy(v):
	return Vector3(v.x, v.y, v.z)
