extends KinematicBody2D

var input_device : int = 0

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
