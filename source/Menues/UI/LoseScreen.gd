extends Control

export(PackedScene) var lvl 
export(PackedScene) var startmenu

func _on_BtnMainMenu_pressed():
	get_tree().change_scene_to(startmenu)

func _on_BtnReplay_pressed():
	get_tree().change_scene_to(lvl)
