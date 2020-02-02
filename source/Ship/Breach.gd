extends Sprite

func interact(player):
	if player.has_supplies:
		get_parent().get_parent().repair()
		return "breach"
	else:
		return ""


func _on_BreachArea_body_entered(body : Player) -> void:
	body.enable_interaction(self)


func _on_BreachArea_body_exited(body : Player) -> void:
	body.disable_interaction(self)
