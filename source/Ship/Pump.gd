extends Area2D

export var drainspeed : float = 10.2

func _on_InteractionArea_body_entered(body):
	body.enable_interaction(self)

func _on_InteractionArea_body_exited(body):
	body.enable_interaction(self)

func intercation_Breack():
	get_parent().get_parent().drain(drainspeed)
	return "pump"
