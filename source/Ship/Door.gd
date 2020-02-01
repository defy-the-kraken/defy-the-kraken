extends AnimatedSprite

enum {CLOSED, OPEN}

func toggle() -> void:
	if frame == CLOSED:
		open()
	else:
		close()

func open() -> void:
	frame = OPEN

func close() -> void:
	frame = CLOSED
