extends Area2D

func _on_Material_boxen_body_entered(body):
	body.supply()
