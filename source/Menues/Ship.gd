extends Sprite

export var speed := 5
var posi = Vector2()
var on = true
var rng = RandomNumberGenerator.new()

func _process(Delta):
	move_local_x(-speed)

func _on_Timer_timeout():
	if (on == true):
		posi = self.position
		on = false
	position = posi
	speed = rng.randi_range(0, 5)
	if speed > 1:
		get_parent().get_node("Timer").start(7)
	else:
		get_parent().get_node("Timer").start(13)
