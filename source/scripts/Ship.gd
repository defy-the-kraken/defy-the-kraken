extends Node2D

signal room_update
signal game_over

# Timer configs
export (float) var min_breach_time = 1
export (float) var max_breach_time = 2

var rooms_filled : Array = []
var rooms_not_breached : Array = []
var rng : RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	for room in $Rooms.get_children():
		room.connect("room_filled", self, "on_room_filled")
		rooms_not_breached.append(room)


func set_breach_timer():
	var time : float = rng.randf_range(min_breach_time, max_breach_time)
	$BreachTimer.start(time)


func on_room_filled(room, is_filled) -> void:
	if is_filled:
		rooms_filled.append(room)
	else:
		rooms_filled.remove(rooms_filled.bsearch(room))
	emit_signal("room_update", rooms_filled.size(), $Rooms.get_child_count())


func _on_BreachTimer_timeout():
	var room_idx : int = rng.randi_range(0, rooms_not_breached.size() - 1)
	var room = rooms_not_breached[room_idx]
	room.breach()
	rooms_not_breached.remove(room_idx)
	# If there are rooms left, restart the timer
	if rooms_not_breached:
		set_breach_timer()