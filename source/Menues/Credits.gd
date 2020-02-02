extends Control

func _process(delta):
	OS.window_size = Vector2(1000, 600)
	
	if Input.is_key_pressed(KEY_ESCAPE) || Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene("res://Menues/start_menu.tscn")
