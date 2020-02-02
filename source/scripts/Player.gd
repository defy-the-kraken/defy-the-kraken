extends KinematicBody2D

var input_device : int = 0
var can_climb : bool = false
var has_material : bool = false
var avail_interact = null

enum {
	MOVE_LEFT,
	MOVE_RIGHT, 
	IDLE, 
	CLIMB_UP, 
	CLIMB_DOWN,
	IDLE_CLIMB, 
	PUMPING
	}
var state : int = IDLE

func _input(event : InputEvent) -> void:
	if not event.is_action_type():
		return
	# is it an activateion
	if event.is_pressed():
		# Discard all inputs while pumping
		if state == PUMPING:
			return
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
			PUMPING:
				if event.is_action_released("interact"):
					change_state(IDLE)
			_: change_state(IDLE)


func change_state(new_state : int) -> void:
	# Check for actual state change
	if new_state == state:
		return
	state = new_state

func supply() -> void:
	has_material = true


func enable_interaction(interaction : Node2D):
	avail_interact = interaction

func disable_interaction(interaction : Node2D):
	if avail_interact == interaction:
		avail_interact = null


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
