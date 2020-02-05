extends AnimatedSprite

enum {CLOSED, OPEN}

export (float) var water_throughput = 50
export (float) var water_throughput_closed = 0.0

func interact(body : Player) -> String:
	if frame == CLOSED:
		open()
		body.can_pass_floor = true
	else:
		close()
		body.set_collision_mask_bit(1, true)
	return "hatch"

func open() -> void:
	frame = OPEN

func close() -> void:
	frame = CLOSED

func is_open() -> bool:
	if frame == OPEN:
		return true
	return false

func _on_Body_body_entered(body : Player) -> void:
	body.enable_interaction(self)
	$InteractionHint.show()
	if frame == OPEN:
		body.can_pass_floor = true
	else:
		body.set_collision_mask_bit(1, true)

func _on_Body_body_exited(body : Player) -> void:
	body.disable_interaction(self)
	$InteractionHint.hide()
	body.can_pass_floor = false
