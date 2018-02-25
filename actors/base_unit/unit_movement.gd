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
	#if(len(pts) == 0):
	#	print("DONE")
	#	return
	#print ("DEST", destination)
	#return
	#var pt1
	#print("LEN", len(pts))
	#for i in len(pts):
	#	pt1 = pts[0]
	#	var diff = pos - pt1
	#	if abs(diff.x) < 0.05 and abs(diff.z) < 0.05:
	#		pts.remove(0)
	#	else:
	#		print("BREAK")
	#		break
	#
	#print(len(pts))
	#destination = pt1
	redraw_destination_lines(pts)
	
	var dir = (destination - pos)
	dir.y = 0
	dir = dir.normalized()
	velocity.y += delta * GRAVITY 
	velocity.y = max(-20, velocity.y)
	#print("DIR"
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
	var max_slides = 14
	var floor_max_angle = deg2rad(10)
	print("VELOCITY", velocity)
	velocity = node.move_and_slide(velocity, UP)
	#velocity = node.move_and_slide(velocity, UP)
	print("LEFTOVER", velocity)
	#print("TRAN", node.translation)
	#print("SLIDE COUNT", node.get_slide_count())
	print("COLL?", node.is_on_floor(), node.is_on_wall(), node.is_on_ceiling())
	if velocity.y == -1:
		pass
	return
	
func _init(n):
	node = n
	
	m.params_line_width = (2.0)
	m.params_point_size = (2.0)
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
	print("DRAW", len(pts))
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
