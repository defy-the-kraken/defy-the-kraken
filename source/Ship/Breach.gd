extends Area2D

func _on_InteractionArea_body_entered(body):
	body.enable_interaction(self)

func _on_InteractionArea_body_exited(body):
	body.enable_interaction(self)

func intercation_Breach(body):
	if body.has_supplies:
		get_parent().get_parent().repair()
		return "breach"
	else:
		return ""
