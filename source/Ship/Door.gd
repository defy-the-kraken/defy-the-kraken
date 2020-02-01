extends AnimatedSprite

enum {CLOSED, OPEN}

func toggle() -> void:
	if frame == CLOSED:
		open()
	else:
		close()

func open() -> void:
	frame = OPEN
	$Body/Shape.disabled = false

func close() -> void:
	frame = CLOSED
	$Body/Shape.disabled = true
