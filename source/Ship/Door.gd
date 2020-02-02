extends AnimatedSprite

enum {CLOSED, OPEN}

func interact(body : Player) -> void:
	if frame == CLOSED:
		open()
	else:
		close()

func open() -> void:
	frame = OPEN

func close() -> void:
	frame = CLOSED

func _on_Body_body_entered(body : Player) -> void:
	body.enable_interaction(self)

func _on_Body_body_exited(body : Player) -> void:
	body.disable_interaction(self)
