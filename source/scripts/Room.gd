extends StaticBody2D


var lowest_point : Vector2
var highest_point: Vector2
var water_level : float = 0


func _ready() -> void:
	# Determine the lowest point in the room, to place the waterlight  and
	# water texture in
	#
	# Note: This requires the shape of the room to be convex. One option to
	# expand this to concave rooms would be to place on light at every vertex
	# and turn them on as soon as they are below the water level.
	for vertex in $Boundaries.polygon:
		if (vertex as Vector2).y > lowest_point.y:
			lowest_point = vertex
	$Water/Light.position = lowest_point
	$Water/Light.position.y -= 20
	$Water/Texture.position = lowest_point
	# Make the water boundaries polygon the same as the room shape so the water
	# light doesn't illuminate the water of adjacent rooms
	$Water/Boundaries.occluder = OccluderPolygon2D.new()
	$Water/Boundaries.occluder.polygon = $Boundaries.get_polygon()
