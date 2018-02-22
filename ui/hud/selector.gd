extends Node2D

export var draw = 0
var rect_color = Color(1,1,1)
var corner1
var corner2
var corner3
var corner4
var selecting_start = Vector2(0,0)

func _ready():
	pass

func _input(event):
	if event.is_action_pressed('ui_select'):
		# print("YES")
		selecting_start = event.position
	if selecting_start.x > 0:
		draw_rect(selecting_start, event.position)
		get_units_selection(event.position)
		update()
		if event.is_action_released("ui_select"):
			selecting_start = Vector2(0, 0)
			hide_rect()

func _draw():
	if draw:
		draw_line( corner1, corner2, rect_color )
		draw_line( corner2, corner3, rect_color )
		draw_line( corner3, corner4, rect_color )
		draw_line( corner4, corner1, rect_color )
	
func draw_rect(start_corner,end_corner):
	corner1 = start_corner
	corner2 = Vector2(start_corner.x, end_corner.y)
	corner3 = end_corner
	corner4 = Vector2(end_corner.x, start_corner.y)
	draw = 1
	update()

	
func hide_rect():
	draw = 0
	
func get_units_selection(drag_position):
	var viewport = get_viewport()
	var camera = viewport.get_camera()
	var units = get_tree().get_nodes_in_group("units")
	for unit in units:
		var loc_on_screen = camera.unproject_position(unit.get_translation())
		if loc_on_screen.distance_to(drag_position) < 20:
			pass
			#unit.select()
		if is_point_in_rectangle(loc_on_screen, selecting_start, drag_position):
			# unit.select()
			#unit.show_destination_line(1)
			pass

	
func is_point_in_rectangle(point, rect_start, rect_end):
	var x = point.x
	var y = point.y
	if ( (rect_start.x > x and x > rect_end.x) or (rect_start.x  < x and x < rect_end.x )):
		if ( ( rect_start.y > y and y > rect_end.y) or (rect_start.y < y and y < rect_end.y )):
			return true
	return false
	