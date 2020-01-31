extends Control


func _ready() -> void:
	#set_progress(0)
	pass


func set_progress(progress : float) -> void:
	$Progress/DistanceDone.size_flags_stretch_ratio = progress
	$Progress/DistanceLeft.size_flags_stretch_ratio = 1 - progress
