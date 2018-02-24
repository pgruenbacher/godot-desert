extends Camera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var target_position = Vector3()

var X = Vector3(1,0,0)
var Y = Vector3(0,1,0)
var Z = Vector3(0,0,1)

func set_up():
	rotation_degrees.z = 0
	
func set_focus():
	var up = Vector3(0,1,0)
	look_at(target_position, up)
	
	

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_focus()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
