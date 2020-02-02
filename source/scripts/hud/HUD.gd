extends Control


func update_room_counter(filled, total) -> void:
	$RoomCounter.text = "Rooms filled: " + str(filled) + "/" + str(total)


func set_level_progress(progress : float) -> void:
	$LevelProgress.set_progress(progress)
