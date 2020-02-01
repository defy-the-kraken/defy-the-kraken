extends Control

var entry_full := false
var entry_resize := false

func set_fullscreen():
	if entry_full == true:
		entry_full = false
	else:
		entry_full = true
		entry_resize = true
		set_resizable()
	OS.window_fullscreen = entry_full

func set_resizable():
	if entry_resize == true:
		entry_resize = false
	else:
		entry_resize = true
		entry_full = true
		set_fullscreen()
	OS.window_resizable = entry_resize

func set_Res(width, height):
	if entry_full == true:
		set_fullscreen()
	elif entry_resize == true:
		set_resizable()
	if height > 0 && width > 0:
		OS.window_size = Vector2(width, height)
	else:
		pass

func set_scale_data(auswahl):
	var width = int(auswahl.substr(0, auswahl.find("x")))
	var height = int(auswahl.substr(auswahl.find("x"), auswahl.length()-1))
	set_Res(width, height)

#Set Resolution scaling 
func set_scaling(text):
	if text == "16:9":
		$Grid/MarginContainer/if_16_9.visible = true
		set_scale_data($Grid/MarginContainer/if_16_9.text)
		$Grid/MarginContainer/if_16_10.visible = false
		$Grid/MarginContainer/if_4_3.visible = false
	elif text == "16:10":
		$Grid/MarginContainer/if_16_9.visible = false
		$Grid/MarginContainer/if_16_10.visible = true
		set_scale_data($Grid/MarginContainer/if_16_10.text)
		$Grid/MarginContainer/if_4_3.visible = false
	elif text == "4:3":
		$Grid/MarginContainer/if_16_9.visible = false
		$Grid/MarginContainer/if_16_10.visible = false
		$Grid/MarginContainer/if_4_3.visible = true
		set_scale_data($Grid/MarginContainer/if_4_3.text)

func _on_Accept_pressed():
	if entry_full:
		get_tree().change_scene("res://Menues/start_menu.tscn")
	elif entry_resize:
		entry_resize = !entry_resize
		set_resizable()
		get_tree().change_scene("res://Menues/start_menu.tscn")
	get_tree().change_scene("res://Menues/start_menu.tscn")
	
	get_tree().change_scene("res://Menues/start_menu.tscn")

func _on_Cancel_pressed():
	get_tree().change_scene("res://Menues/start_menu.tscn")

func _on_Resolution_selected(id):
	set_scaling(str($Grid/Res.text))

func _on_19_6_selected(id):
	var auswahl := str($Grid/MarginContainer/if_16_9.text)
	set_scale_data(auswahl)

func _on_16_10_item_selected(id):
	var auswahl := str($Grid/MarginContainer/if_16_10.text)
	set_scale_data(auswahl)

func _on_4_3_item_selected(id):
	var auswahl := str($Grid/MarginContainer/if_4_3.text)
	set_scale_data(auswahl)

func _on_Fullscreen_pressed():
	set_fullscreen()

func _on_Resizeable_pressed():
	set_resizable()
