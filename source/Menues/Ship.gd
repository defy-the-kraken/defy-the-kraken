extends Sprite

export var speed := 5
var posi = Vector2()
var on = true

func _process(Delta):
	self.move_local_x(-speed)

func _on_Timer_timeout():
	posi = self.position
	self.position = posi
	$Timer.start(10)
