extends KinematicBody2D

export (int) var walk_speed = 50
export (int) var climb_speed = 30
export (int) var gravity = 50

var input_device : int = 0
var can_climb : bool = true
var has_supplies : bool = false
var avail_interact : Node2D = null
var velocity : Vector2 = Vector2.ZERO

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
		if event.is_action_pressed("interact"):
			if avail_interact and avail_interact.has_method("interact"):
				avail_interact.interact()
		elif event.is_action_pressed("move_up") and can_climb:
			change_state(CLIMB_UP)
		elif event.is_action_pressed("move_down") and can_climb:
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
	match state:
		MOVE_LEFT:
			$Sprite.animation = "walk"
			$Sprite.flip_h = true
			$Sprite.playing = true
			print_debug("State changed: Move left")
		MOVE_RIGHT:
			$Sprite.animation = "walk"
			$Sprite.flip_h = false
			$Sprite.playing = true
			print_debug("State changed: Move right")
		IDLE:
			$Sprite.animation = "idle"
		CLIMB_UP, CLIMB_DOWN:
			$Sprite.animation = "climb"
			$Sprite.playing = true
		CLIMB_IDLE:
			$Sprite.animation = "climb"
			$Sprite.playing = false
		

func supply() -> void:
	has_supplies = true

func enable_interaction(interaction : Node2D):
	avail_interact = interaction

func disable_interaction(interaction : Node2D):
	if avail_interact == interaction:
		avail_interact = null

func _physics_process(delta : float) -> void:
	match state:
		MOVE_LEFT:
			velocity = Vector2(-walk_speed, gravity)
		MOVE_RIGHT:
			velocity = Vector2(walk_speed, gravity)
		IDLE:
			velocity = Vector2(0, gravity)
		CLIMB_UP:
			velocity = Vector2(0, -climb_speed)
		CLIMB_DOWN:
			velocity = Vector2(0, climb_speed)
		_: velocity = Vector2.ZERO
	move_and_slide(velocity)

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
