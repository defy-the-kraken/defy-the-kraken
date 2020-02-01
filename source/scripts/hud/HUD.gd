extends Control


func update_room_counter(filled, total) -> void:
	$RoomCounter.text = "Rooms filled: " + str(filled) + "/" + str(total)


func set_level_progress(progress : float) -> void:
	$LevelProgress.set_progress(progress)


func show_win_screen() -> void:
	$WinScreen.show()

func show_lose_screen() -> void:
	$LoseScreen.show()

func _on_BtnReplay_button_up():
	get_tree().reload_current_scene()


func _on_BtnMainMenu_button_up():
	print_debug("Main Menu not yet implemented")
