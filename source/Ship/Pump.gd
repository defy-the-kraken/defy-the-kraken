extends Sprite

func interact(_player):
	if get_parent().get_waterlevel() == 0:
		return ""
	get_parent().drain(get_parent().drain_speed)
	return "pump"


func _on_PumpArea_body_entered(body : Player) -> void:
	body.enable_interaction(self)


func _on_PumpArea_body_exited(body : Player) -> void:
	body.disable_interaction(self)
