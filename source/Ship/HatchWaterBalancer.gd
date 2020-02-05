extends Node2D

var room_up : Room = null
var room_down : Room = null

func get_adjacent_rooms() -> void:
	# Get room on the top
	$Up.force_raycast_update()
	if $Up.is_colliding():
		if $Up.get_collider() is Room:
			room_up = $Up.get_collider()
	# Get room on the bottom
	$Down.force_raycast_update()
	if $Down.is_colliding():
		if $Down.get_collider() is Room:
			room_down = $Down.get_collider()
	print_debug(get_parent().name, " ", room_up, " ", room_down)

func _physics_process(delta : float) -> void:
	if not room_up and not room_down:
		get_adjacent_rooms()
	if room_up and room_down:
		var throughput
		if get_parent().is_open():
			throughput = get_parent().water_throughput
		else:
			throughput = get_parent().water_throughput_closed
		# Both sides are rooms and the door is open
		var water_diff = abs(room_up.get_waterlevel() - room_down.get_waterlevel())
		if room_up.get_waterlevel() > room_down.get_waterlevel():
			room_up.drain(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
			room_down.flood(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
		else:
			room_up.flood(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
			room_down.drain(
				min(
					throughput * delta,
					water_diff / 2
					)
				)
	
