extends Sprite

var is_pumping = false

func interact(_player):
	if get_parent().get_waterlevel() == 0:
		return ""
	is_pumping = true
	return "pump"
	
func stop_interaction() -> void:
	is_pumping = false

func _physics_process(delta : float) -> void:
	if is_pumping:
		get_parent().drain(get_parent().drain_speed * delta)

func _on_PumpArea_body_entered(body : Player) -> void:
	body.enable_interaction(self)


func _on_PumpArea_body_exited(body : Player) -> void:
	body.disable_interaction(self)
