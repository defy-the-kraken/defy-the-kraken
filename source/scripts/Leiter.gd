extends Sprite



func _on_Area2D_body_entered(body : Player):
	body.enable_climb(self)



func _on_Area2D_body_exited(body : Player):
	body.disable_climb(self)
