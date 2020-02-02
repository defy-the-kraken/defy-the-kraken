extends Area2D

signal room_filled

export (int) var flood_speed = 10

var room_size : Vector2
var is_breached : bool = false
var is_full : bool = false


func _ready():
	$Water.show()
	room_size = $Shape.shape.extents
	# Position the water
	# 256 is the size of the water texture
	var scale = room_size * 2 / 256
	$Water.rect_scale = scale
	$Water.rect_position = -room_size
	# Position the breach
	$Breach.position.x = room_size.x * .5
	# Position the Pump
	$Pump.position.x = room_size.x * -.5
	$Pump.position.y = room_size.y

func breach() -> void:
	is_breached = true
	$Breach.show()

func repair() -> void:
	is_breached = false
	$Breach.hide()

func _physics_process(delta) -> void:
	if is_breached:
		flood(delta * flood_speed)
	
	# Check if the room filled up
	if not is_full and $Water.value >= $Water.max_value:
		is_full = true
		emit_signal("room_filled", self, true)
	# Check if the room is no longer full
	elif is_full and $Water.value < $Water.max_value:
		is_full = false
		emit_signal("room_filled", self, false)

func flood(amount : float) -> void:
	$Water.value += amount

func drain(amount : float) -> void:
	$Water.value -= amount


#func _on_InteractionArea_body_entered(body):
#	body.enable_ineraction(self.get_parent())
	

#func _on_InteractionArea_body_exited(body):
#	body.disable_interaction(.get_parent())
