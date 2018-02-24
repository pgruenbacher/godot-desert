extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var selected = false setget set_selected, get_selected
var UnitMovement = preload('./unit_movement.gd')

onready var UnitMover = UnitMovement.new(self)


func get_selected():
	return selected

func set_selected(val):
	if selected != val and selected:
		show_selected()
	elif selected != val and not selected:
		hide_selected()
	selected = val
	
func show_selected():
	show_selection_icon(true)
	show_unit_icon(true)

func hide_selected():
	show_selection_icon(false)
	show_unit_icon(false)
	
func show_selection_icon(val):
	$SelectedIcon.visible = val
	
func show_unit_icon(val):
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization her
	UnitMover.destination = Vector2(200, 400)
	UnitMover.get_new_velocity()

func _process(delta):
	var cam = get_tree().get_root().get_camera()
	var screenPos = cam.unproject_position(translation)
	get_node('SelectedIcon').set_position(Vector2(screenPos.x, screenPos.y))
