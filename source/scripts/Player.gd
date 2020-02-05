extends KinematicBody2D

signal game_over

class_name Player

export (int) var walk_speed = 50
export (int) var climb_speed = 30
export (float) var drown_time = 4.0
export (int) var gravity = 50

export (float) var repair_duration = 2
export (float) var pump_duration = 1



var input_device : int = 0
var ladder_stack : Array = []
var can_pass_floor : bool = false
var has_supplies : bool = false
var interaction_stack : Array = []
var velocity : Vector2 = Vector2.ZERO
var current_rooms : Array = []

enum {
	MOVE_LEFT,
	MOVE_RIGHT, 
	IDLE, 
	CLIMB_UP, 
	CLIMB_DOWN,
	CLIMB_IDLE,
	PUMPING,
	REPAIRING
	}
var state : int = IDLE

func _input(event : InputEvent) -> void:
	if not event.is_action_type():
		return
	# is it an activateion
	if event.is_pressed():
		# discard input if repairing or pumping
		if state in [PUMPING, REPAIRING]:
			return
		if event.is_action_pressed("interact"):
			#print_debug("Interact pressed")
			if interaction_stack:
				var action = interaction_stack[interaction_stack.size() - 1].interact(self)
				start_action(action)
		elif event.is_action_pressed("move_up") and ladder_stack:
			change_state(CLIMB_UP)
		elif event.is_action_pressed("move_down") and ladder_stack:
			change_state(CLIMB_DOWN)
		elif event.is_action_pressed("move_left"):
			change_state(MOVE_LEFT)
		elif event.is_action_pressed("move_right"):
			change_state(MOVE_RIGHT)
	# or is it a deactivation
	else:
		match state:
			MOVE_LEFT:
				if event.is_action("move_left"):
					change_state(IDLE)
			MOVE_RIGHT:
				if event.is_action("move_right"):
					change_state(IDLE)
			CLIMB_UP:
				if event.is_action("move_up"):
					change_state(CLIMB_IDLE)
			CLIMB_DOWN:
				if event.is_action("move_down"):
					change_state(CLIMB_IDLE)

func change_state(new_state : int) -> void:
	# Check for actual state change
	if new_state == state:
		return
	# save the state
	state = new_state
	# Switch animation
	set_collision_mask_bit(1, true)
	match state:
		MOVE_LEFT:
			$Sprite.animation = "walk"
			$Sprite.flip_h = true
			$Sprite.playing = true
		MOVE_RIGHT:
			$Sprite.animation = "walk"
			$Sprite.flip_h = false
			$Sprite.playing = true
		IDLE:
			$Sprite.animation = "idle"
		CLIMB_UP, CLIMB_DOWN:
			$Sprite.animation = "climb"
			$Sprite.playing = true
			set_collision_mask_bit(1, !can_pass_floor)
		CLIMB_IDLE:
			$Sprite.animation = "climb"
			$Sprite.playing = false
			set_collision_mask_bit(1, !can_pass_floor)
		PUMPING:
			$Sprite.animation = "pump"
			$Sprite.playing = true
			$InteractionTimer.start(pump_duration)
		REPAIRING:
			$Sprite.animation = "repair"
			$Sprite.playing = true
			$InteractionTimer.start(repair_duration)
			has_supplies = false
			$SupplyMarker.hide()
		

func supply() -> void:
	has_supplies = true
	$SupplyMarker.show()

func enable_interaction(interaction : Node2D):
	interaction_stack.append(interaction)
	#print_debug("Interaction available: ", interaction.name)

func disable_interaction(interaction : Node2D):
	var idx = interaction_stack.find_last(interaction)
	if idx != -1:
		interaction_stack.remove(idx)

func _physics_process(delta : float) -> void:
	match state:
		MOVE_LEFT:
			velocity = Vector2(-walk_speed, gravity)
			set_collision_mask_bit(1, true)
		MOVE_RIGHT:
			velocity = Vector2(walk_speed, gravity)
			set_collision_mask_bit(1, true)
		IDLE:
			velocity = Vector2(0, gravity)
			set_collision_mask_bit(1, true)
		CLIMB_UP:
			velocity = Vector2(0, -climb_speed)
			set_collision_mask_bit(1, !can_pass_floor)
		CLIMB_DOWN:
			velocity = Vector2(0, climb_speed)
			set_collision_mask_bit(1, !can_pass_floor)
		_: velocity = Vector2.ZERO
	velocity *= get_slowdown()
	move_and_slide(velocity)
	if is_drowning():
		$DrowningBar.value += 100 / drown_time * delta
	else:
		$DrowningBar.value -= 100 / drown_time * delta * 8

func enter_room(room) -> void:
	var idx = current_rooms.find(room)
	if idx == -1:
		current_rooms.append(room)

func leave_room(room) -> void:
	var idx = current_rooms.find(room)
	if idx != -1:
		current_rooms.remove(idx)

func get_slowdown() -> float:
	var max_water_level : float = 0
	for room in current_rooms:
		max_water_level = max(room.get_waterlevel(), max_water_level)
	var slowdown = (100 - max_water_level) / 100
	slowdown = slowdown /2 + .5
	return slowdown

func start_action(action : String) -> void:
	match action:
		"pump":
			change_state(PUMPING)
		"breach":
			change_state(REPAIRING)
		_:
			pass

func is_drowning() -> bool:
	for room in current_rooms:
		if room.get_waterlevel() > 99:
			return true
	return false

func _on_InteractionTimer_timeout() -> void:
	change_state(IDLE)
	interaction_stack[interaction_stack.size() - 1].stop_interaction()

func enable_climb(ladder) -> void:
	if ladder_stack.find(ladder) == -1:
		ladder_stack.append(ladder)

func disable_climb(ladder) -> void:
	var idx = ladder_stack.find_last(ladder)
	if idx != -1:
		ladder_stack.remove(idx)
	if not ladder_stack:
		if Input.is_action_pressed("move_left"):
			change_state(MOVE_LEFT)
		elif Input.is_action_pressed("move_right"):
			change_state(MOVE_RIGHT)
		else:
			change_state(IDLE)


func _on_DrowningBar_value_changed(value):
	if value == 100:
		emit_signal("game_over")
