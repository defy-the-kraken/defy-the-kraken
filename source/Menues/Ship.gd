extends Sprite

export var speed := 5
var posi = Vector2()
var on = true
var rng = RandomNumberGenerator.new()

func _process(_Delta):
	move_local_x(-speed)

func _on_Timer_timeout():
	if (on == true):
		posi = Vector2(OS.window_size)
		posi.x = posi.x+(posi.x / 100 * 20)
		posi.y = int(posi.y / 2)
		on = false
	position = posi
	speed = rng.randi_range(0, 4)
	if speed > 1:
		get_parent().get_parent().get_node("Timer").start(12)
	else:
		get_parent().get_parent().get_node("Timer").start(30)
