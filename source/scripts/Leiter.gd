extends Sprite



func _on_Area2D_body_entered(body : Player):
	body.can_climb = true



func _on_Area2D_body_exited(body : Player):
	body.stop_climb()
