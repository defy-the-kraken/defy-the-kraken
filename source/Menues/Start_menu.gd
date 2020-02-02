extends Control


func _on_Play__Solo_button_down():
	get_tree().change_scene("res://Level.tscn")


func _on_Local_co_op_button_down():
	$"Buttons/Local co op".text = "not available atm"


func _on_Preferences_button_down():
	get_tree().change_scene("res://Menues/Preferences.tscn")


func _on_credits_button_down():
	get_tree().change_scene("res://Menues/Credits.tscn")


func _on_Quit_button_down():
	get_tree().quit()
