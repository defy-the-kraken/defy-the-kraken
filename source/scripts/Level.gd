extends Node

# How long is the journey in this level
export (float) var length = 1000
# How many steps per second shall the ship take
export (float) var speed = 100

# How many steps did the ship take so far
var progress : float = 0


func _ready() -> void:
	$HUD.set_level_progress(progress)


func _process(delta : float) -> void:
	# Advance the level progress
	progress += speed * delta
	$HUD.set_level_progress(progress / length)
	# Check if level has been completed
	if progress >= length:
		set_process(false)
		$HUD.show_win_screen()

