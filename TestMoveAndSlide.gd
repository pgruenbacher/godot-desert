extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func move_and_slide(p_linear_velocity, p_floor_direction, p_slope_stop_min_velocity = 0.05, p_max_slides = 4, p_floor_max_angle = deg2rad(45)):

	var lv = p_linear_velocity

	#for i in 3:
	#	if (locked_axis & (1 << i)):
	#		lv[i] = 0;

	var motion = (get_floor_velocity() + lv) * get_physics_process_delta_time()

	var on_floor = false;
	var on_ceiling = false;
	var on_wall = false;
	# colliders.clear();
	var floor_velocity = Vector3();

	while (p_max_slides):

		var collision = move_and_collide(motion, collision);

		if (collision):

			motion = collision.remainder;

			if (p_floor_direction == Vector3()):
				#all is a wall
				on_wall = true;
			else:
				if (collision.normal.dot(p_floor_direction) >= cos(p_floor_max_angle)):

					on_floor = true;
					floor_velocity = collision.collider_vel;

					rel_v = lv - floor_velocity;
					hv = rel_v - p_floor_direction * p_floor_direction.dot(rel_v);

					if (collision.travel.length() < 0.05 && hv.length() < p_slope_stop_min_velocity):
						var gt = get_global_transform();
						gt.origin -= collision.travel;
						set_global_transform(gt);
						return floor_velocity - p_floor_direction * p_floor_direction.dot(floor_velocity);
					
				elif (collision.normal.dot(-p_floor_direction) >= cos(p_floor_max_angle)):
					on_ceiling = true;
				else:
					on_wall = true;

			var n = collision.normal;
			motion = motion.slide(n);
			lv = lv.slide(n);

			#for i in 3:
			#	if (locked_axis & (1 << i)):
			#		lv[i] = 0;
			

			colliders.push_back(collision);

		else:
			break;
		

		p_max_slides =- 1;
		if (motion == Vector3()):
			break;
	

	return lv;
