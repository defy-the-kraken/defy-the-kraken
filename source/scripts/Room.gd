extends StaticBody2D

enum {DRY, DRAINING, WET, FLOODING, FULL}

export (float) var flooding_speed = 10

var lowest_point : Vector2
var highest_point: Vector2
# The vector along which the $Water/Level Node travels
# This is done to avoid the water level leaving the room
var water_level_vect : Vector2
var water_level : float = 0
var state : int = DRY


func _ready() -> void:
	# Determine the lowest point in the room to place the waterlight  and
	# water texture in
	# Also determine the highest point in the room to determine when the
	# room is full
	#
	# Note: This requires the shape of the room to be convex. One option to
	# expand this to concave rooms would be to place on light at every vertex
	# and turn them on as soon as they are below the water level.
	highest_point = $Boundaries.polygon[0]
	lowest_point = $Boundaries.polygon[0]
	for vertex in $Boundaries.polygon:
		if vertex.y > lowest_point.y:
			lowest_point = vertex
		if highest_point.y > vertex.y:
			highest_point = vertex
	# Add a margin to the edge to avoid illuminating areas outside the room
	lowest_point.y += -2
	highest_point.y += 4
	water_level_vect = (highest_point - lowest_point)
	water_level_vect /= abs(water_level_vect.y)
	$Water/Level.position = lowest_point
	$Water/Light.position = lowest_point
	$Water/Light.position.y -= 1
	$Water/Texture.position = lowest_point
	$Water/Texture.position.y -= 1
	# Make the water boundaries polygon the same as the room shape so the water
	# light doesn't illuminate the water of adjacent rooms
	$Water/Boundaries.occluder.polygon = $Boundaries.polygon
	# Create collision borders for the player
	create_walls()
	change_state(FLOODING)
	


func _physics_process(delta) -> void:
	match state:
		FLOODING:
			flood(delta)
		_: pass


func change_state(new_state : int) -> void:
	match new_state:
		DRY:
			state = DRY
			water_level = 0
			$Water.visible = false
		FLOODING:
			state = FLOODING
			$Water.visible = true
			$Water/Level.visible = true
		FULL:
			state = FULL
			$Water/Level.visible = false
			
		_: pass


func flood(amount : float) -> void:
	amount *= flooding_speed
	if (lowest_point.y - water_level - amount) <= highest_point.y:
		change_state(FULL)
		return
	water_level = max(amount, water_level + amount)
	adjust_water_surface()
	

func adjust_water_surface() -> void:
	$Water/Level.position = lowest_point + (water_level_vect * (water_level + 3))
	# Measure the boundaries to the left and right
	$Water/Level/MeasureLeft.force_raycast_update()
	var left_edge : Vector2 
	left_edge = $Water/Level/MeasureLeft.get_collision_point()
	left_edge = $Water/Level.to_local(left_edge) + Vector2(-1,0)
	$Water/Level/MeasureRight.force_raycast_update()
	var right_edge : Vector2
	right_edge = $Water/Level/MeasureRight.get_collision_point()
	right_edge = $Water/Level.to_local(right_edge) + Vector2(1,0)
	# Adjust the water surface
	$Water/Level/Surface.points = [left_edge, right_edge]
	print_debug($Water/Level/Surface.points)
	$Water/Level/SurfaceShadow.occluder.polygon = [
		left_edge,
		left_edge + Vector2(-1, -1),
		right_edge + Vector2(1, -1),
		right_edge
	]
	$Water/Light.position = $Water/Level.position + Vector2(0, 2)
	

func create_walls() -> void:
	for i in range($Boundaries.polygon.size()):
		var wall = StaticBody2D.new()
		var wall_shape = CollisionPolygon2D.new()
		var point_a : Vector2 = $Boundaries.polygon[i]
		var point_b : Vector2 = $Boundaries.polygon[(i+1) % $Boundaries.polygon.size()]
		wall_shape.polygon = [point_a, point_a + Vector2(0, 1), point_b + Vector2(0,1), point_b]
		wall.add_child(wall_shape)
		add_child(wall)
		
