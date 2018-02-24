extends Spatial

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
	Camera.look_at(target_position, up)
	

var direction = Vector3()
var velocity = Vector3()
var rotation_value = Vector3()
var MAX_SPEED = 6
var MAX_ROTATION = deg2rad(1) # degrees
onready var Camera = $TurnTable/PitchTable/Camera

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_focus()
	set_process(false)
	
func _process(delta):
	var transform = Camera.get_camera_transform()
	var transformed_direction = transform.basis.xform(direction)
	transformed_direction.y = 0
	velocity = transformed_direction * MAX_SPEED
	translate(velocity * delta)
	if direction.x == 0 and direction.z == 0 and rotation_value.y == 0 and rotation_value.x == 0:
		set_process(false)
		
	if rotation_value.x != 0:
		$TurnTable/PitchTable.rotate_x(rotation_value.x * delta)
	if rotation_value.y != 0:
		$TurnTable.rotate_y(rotation_value.y * delta)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	# ui up down etc. should be pan up down etc.
	if event.is_action_pressed('ui_down'):
		direction.z = 1
		set_process(true)
	elif event.is_action_pressed('ui_up'):
		direction.z = -1
		set_process(true)
	elif event.is_action_pressed('ui_right'):
		direction.x = 1 
		set_process(true)
	elif event.is_action_pressed('ui_left'):
		direction.x = -1
		set_process(true)
		
	if event.is_action_released('ui_down'):
		direction.z = 0
	elif event.is_action_released('ui_up'):
		direction.z = 0
	elif event.is_action_released('ui_right'):
		direction.x = 0 
	elif event.is_action_released('ui_left'):
		direction.x = 0
		
	#########################################
	# Camera Rotation
	##########################################
		
	if event.is_action_pressed('rotate_up'):
		rotation_value.x = 1
		set_process(true)
	elif event.is_action_pressed('rotate_down'):
		rotation_value.x = -1 
		set_process(true)
	elif event.is_action_pressed('rotate_right'):
		rotation_value.y = -1
		set_process(true)
	elif event.is_action_pressed('rotate_left'):
		rotation_value.y = 1
		set_process(true)
		
	if event.is_action_released('rotate_up'):
		rotation_value.x = 0
	elif event.is_action_released('rotate_down'):
		rotation_value.x = 0 
	elif event.is_action_released('rotate_right'):
		rotation_value.y = 0
	elif event.is_action_released('rotate_left'):
		rotation_value.y = 0