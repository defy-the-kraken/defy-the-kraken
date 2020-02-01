extends Control


func _on_Play__Solo_button_down():
	get_tree().change_scene("res://Level.tscn")


func _on_Local_co_op_button_down():
	ProjectSettings.set_setting("display/window/size/Fullscreen", "yes")


func _on_Preferences_button_down():
	pass # Replace with function body.


func _on_credits_button_down():
	pass # Replace with function body.


func _on_Quit_button_down():
	get_tree().quit()


func _on_Local_co_op_pressed():
	#ProjectSettings.set_setting("display/window/size/Fullscreen", true)
	pass
