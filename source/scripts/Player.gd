extends KinematicBody2D

var input_device : int = 0
var can_climb : bool = false
var avail_interact = null

enum {
	MOVE_LEFT,
	MOVE_RIGHT, 
	IDLE, 
	CLIMB_UP, 
	CLIMB_DOWN,
	IDLE_CLIMB, 
	PUMPING,
	REPAIRING
	}
var state : int = IDLE

func _input(event : InputEvent) -> void:
	if not event.is_action_type() or state == REPAIRING:
		return
	# is it an activateion
	if event.is_pressed():
		if event.is_action_pressed("interact"):
			match avail_action:
				PUMP:
					change_state(PUMPING)
				REPAIR:
					change_state(REPAIRING)
		elif event.is_action_pressed("move_up") and can_climb:
			change_state(CLIMB_UP)
		elif event.is_action_pressed("move_down") and can_climb:
			change_state(CLIMB_DOWN)
		elif event.is_action_pressed("move_left"):
			change_state(MOVE_LEFT)
		elif event.is_action_pressed("move_right"):
			change_state(MOVE_RIGHT)
		elif event.is_action_pressed("door") and can_door:
			toggle_door()
			
	# or is it a deactivation
	else:
		match state:
			MOVE_LEFT:
				if event.is_action_released("move_left"):
					change_state(IDLE)
			MOVE_RIGHT:
				if event.is_action_released("move_right"):
					change_state(IDLE)
			CLIMB_UP:
				if event.is_action_released("move_up"):
					change_state(IDLE_CLIMB)
			CLIMB_DOWN:
				if event.is_action_released("move_down"):
					change_state(IDLE_CLIMB)
			_: change_state(IDLE)

func toggle_door() -> void:
	pass

func change_state(new_state : int) -> void:
	# Check for actual state change
	if new_state == state:
		return
	state = new_state

"""
func _physics_process(delta : float) -> void:
	# Check for inputs
	if Input.is_action_pressed("move_right"):
		$Sprite.animation = "walk"
		$Sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		$Sprite.animation = "walk"
		$Sprite.flip_h = true
	elif Input.is_action_pressed("move_up"):
		$Sprite.animation = "climb"
	elif Input.is_action_pressed("move_down"):
		$Sprite.animation = "climb"
	else:
		$Sprite.animation = "idle"
		"""
