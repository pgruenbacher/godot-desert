extends Navigation

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal map_picked
onready var camera_base = get_tree().get_root().get_camera()

func _ready():
	pass
	#m.set_line_width(2)
	##m.set_point_size(2)
	#m.set_flag(SpatialMaterial.FLAG_USE_POINT_SIZE, true)
	#m.albedo_color = Color(0.2, 0.8, 0.2)
	#m.set_flag(SpatialMaterial.FLAG_UNSHADED, true)
	
	#get_tree().get_root().call_deferred("add_child", im)

func _input(event):
	if event.is_action_pressed('ui_select'):
		var point = mouse2coords(event)
		#print(point)
		emit_signal("map_picked", point)

func mouse2coords(event):
	var near = camera_base.project_ray_origin(event.position)
	var far = near + camera_base.project_ray_normal(event.position)*100
	var point = get_closest_point_to_segment(near, far, true)
	#print(near, far)
	#print("POINT", point)
	#redraw_destination_line(near, far)
	#print("closesst", get_closest_point(Vector3(10, 0, 10)))
	return point
	
var im = ImmediateGeometry.new()
var m = SpatialMaterial.new()

func redraw_destination_line(end_point, start_point):
	#end_point.y += 1
	#start_point.y += 0.2
	im.clear()
	im.set_material_override(m)
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	im.add_vertex(start_point)
	im.add_vertex(end_point)
	im.end()