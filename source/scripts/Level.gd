extends Node

export (float) var length = 1000
export (float) var speed = 10

var progress : float = 0


func _ready() -> void:
	$HUD.set_level_progress(progress)


func _process(delta : float) -> void:
	progress += speed * delta
	$HUD.set_level_progress(progress / length)
