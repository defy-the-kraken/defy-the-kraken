extends Node2D

signal room_update
signal game_over

# Timer configs
export (float) var min_breach_time = 1
export (float) var max_breach_time = 2

var rooms_filled : Array = []
var rooms_not_breached : Array = []
var rng : RandomNumberGenerator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	for room in $Rooms.get_children():
		room.connect("room_filled", self, "on_room_filled")
		rooms_not_breached.append(room)

func set_breach_timer() -> void:
	var time : float = rng.randf_range(min_breach_time, max_breach_time)
	$BreachTimer.start(time)

func start() -> void:
	set_breach_timer()

func on_room_filled(room, is_filled) -> void:
	if is_filled:
		rooms_filled.append(room)
	else:
		var idx = rooms_filled.find(room)
		if idx > -1:
			rooms_filled.remove(idx)
	emit_signal("room_update", rooms_filled.size(), $Rooms.get_child_count())
	# Check if all rooms are filled
	if rooms_filled.size() == $Rooms.get_child_count():
		emit_signal("game_over")

func _on_BreachTimer_timeout():
	var room_idx : int = rng.randi_range(0, rooms_not_breached.size() - 1)
	var room = rooms_not_breached[room_idx]
	room.breach()
	rooms_not_breached.remove(room_idx)
	# If there are rooms left, restart the timer
	if rooms_not_breached:
		set_breach_timer()
