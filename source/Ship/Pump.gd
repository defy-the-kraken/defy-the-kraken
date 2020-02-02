extends Sprite

export var drainspeed : float = 10.2

func interact(player):
	get_parent().drain(drainspeed)
	return "pump"


func _on_PumpArea_body_entered(body : Player) -> void:
	body.enable_interaction(self)


func _on_PumpArea_body_exited(body : Player) -> void:
	body.disable_interaction(self)
