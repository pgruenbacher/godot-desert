extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var selected = false setget set_selected, get_selected

func get_selected():
	return selected

func set_selected(val):
	if selected != val and selected:
		show_selected()
	elif selected != val and not selected:
		hide_selected()
	selected = val
	
func show_selected():
	show_selection_icon()
	show_unit_icon()

func hide_selected():
	hide_selection_icon()
	hide_unit_icon()
	
func show_selection_icon():
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var cam = get_tree().get_root().get_camera()
	var screenPos = cam.unproject_position(translation)
	get_node('SelectedIcon').set_position(Vector2(screenPos.x, screenPos.y))
