extends Navigation

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var camera_base = get_tree().get_root().get_camera()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var mesh = $MeshInstance.mesh
	var NavigationMeshInstance = $MeshInstance.get_child(0)
	#NavigationMeshInstance.navmesh = NavigationMesh.new()
	#NavigationMeshInstance.navmesh.create_from_mesh(mesh)
	var c = NavigationMeshInstance.navmesh.get_polygon_count()
	print("C", c)
	print("closesst", get_closest_point(Vector3(10, 0, 10)))
	print("closesst", get_closest_point(Vector3(10, 0, 20)))
	print("closesst", get_closest_point(Vector3(-10, 0, 20)))
	print("closesst", get_simple_path(Vector3(-10, 0, 20), Vector3(10, 0, -20)))
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event.is_action_pressed('ui_select'):
		var point = mouse2coords(event)
		print(point)

func mouse2coords(event):
	var near = camera_base.project_ray_origin(event.position)
	var far = near + camera_base.project_ray_normal(event.position)*100
	var point = get_closest_point_to_segment(near, far)
	#print(near, far)
	
	print("closesst", get_closest_point(Vector3(10, 0, 10)))
	return point