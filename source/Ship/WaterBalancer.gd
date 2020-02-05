extends Node2D

var room_left : Room = null
var room_right : Room = null

func get_adjacent_rooms() -> void:
	# Get room on the left
	$Left.force_raycast_update()
	if $Left.is_colliding():
		if $Left.get_collider() is Room:
			room_left = $Left.get_collider()
	# Get room on the right
	$Right.force_raycast_update()
	if $Right.is_colliding():
		if $Right.get_collider() is Room:
			room_right = $Right.get_collider()
	print_debug(get_parent().name, " ", room_left, " ",  room_right)

func _physics_process(delta : float) -> void:
	if not room_left and not room_right:
		get_adjacent_rooms()
	if room_left and room_right:
		var throughput
		if get_parent().is_open():
			throughput = get_parent().water_throughput
		else:
			throughput = get_parent().water_throughput_closed
		# Both sides are rooms and the door is open
		var water_diff = abs(room_left.get_waterlevel() - room_right.get_waterlevel())
		if room_left.get_waterlevel() > room_right.get_waterlevel():
			room_left.drain(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
			room_right.flood(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
		else:
			room_left.flood(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
			room_right.drain(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
	
