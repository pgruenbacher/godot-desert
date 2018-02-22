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