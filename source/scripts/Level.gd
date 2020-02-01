extends Node

# How long is the journey in this level
export (float) var length = 1000
# How many steps per second shall the ship take
export (float) var speed = 1



# How many steps did the ship take so far
var progress : float = 0


func _ready() -> void:
	$HUD.set_level_progress(progress)
	scale_ship()
	set_physics_process(true)
	$Ship.start()


func _physics_process(delta : float) -> void:
	# Advance the level progress
	progress += speed * delta
	$HUD.set_level_progress(progress / length)
	# Check if level has been completed
	if progress >= length:
		set_physics_process(false)
		$HUD.show_win_screen()


func scale_ship() -> void:
	# Scale the ship to fit the viewport
	var target_size : Vector2 = get_viewport().size - Vector2(40, 100)
	var is_size : Vector2 = $Ship/Sprite.get_rect().size
	var x_scale : float = target_size.x / is_size.x
	var y_scale : float = target_size.y / is_size.y
	x_scale = min(x_scale, y_scale)
	$Ship.scale = Vector2(x_scale, x_scale)
	# Position the ship in the middle of the window
	$Ship.position = get_viewport().size / 2 #+ Vector2(0, 66)



func _on_Ship_room_update(rooms_filled, room_count):
	$HUD.update_room_counter(rooms_filled, room_count)


func _on_Ship_game_over():
	set_physics_process(false)
	$HUD.show_lose_screen()
