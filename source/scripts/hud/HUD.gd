extends Control


func set_level_progress(progress : float) -> void:
	$LevelProgress.set_progress(progress)


func show_win_screen() -> void:
	$WinScreen.visible = true


func _on_BtnReplay_button_up():
	get_tree().reload_current_scene()


func _on_BtnMainMenu_button_up():
	print_debug("Main Menu not yet implemented")
