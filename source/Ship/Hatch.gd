extends AnimatedSprite

enum {CLOSED, OPEN}

func interact(body : Player) -> String:
	if frame == CLOSED:
		open()
		body.set_collision_mask_bit(1, false)
	else:
		close()
		body.set_collision_mask_bit(1, true)
	return "hatch"

func open() -> void:
	frame = OPEN

func close() -> void:
	frame = CLOSED

func _on_Body_body_entered(body : Player) -> void:
	body.enable_interaction(self)
	$InteractionHint.show()
	if frame == OPEN:
		body.set_collision_mask_bit(1, false)
	else:
		body.set_collision_mask_bit(1, true)

func _on_Body_body_exited(body : Player) -> void:
	body.disable_interaction(self)
	$InteractionHint.hide()
	body.set_collision_mask_bit(0, true)
