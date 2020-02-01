extends Control

var height
var width

func set_fullscreen(entry):
	ProjectSettings.set_setting("application/display/window/size/Fullscreen", str(entry))

func set_resizable(entry):
	ProjectSettings.set_setting("application/config/name", str(entry))
	pass

func set_Res(height, width):
	ProjectSettings.set_setting("application/config/name", "Example")
	pass

#Set Resolution scaling 
func set_scaling(text):
	if text == "16:9":
		$Grid/MarginContainer/if_16_9.visible = true
		$Grid/MarginContainer/if_16_10.visible = false
		$Grid/MarginContainer/if_4_3.visible = false
	elif text == "16:10":
		$Grid/MarginContainer/if_16_9.visible = false
		$Grid/MarginContainer/if_16_10.visible = true
		$Grid/MarginContainer/if_4_3.visible = false
	elif text == "4:3":
		$Grid/MarginContainer/if_16_9.visible = false
		$Grid/MarginContainer/if_16_10.visible = false
		$Grid/MarginContainer/if_4_3.visible = true

func _on_Accept_pressed():
	pass # Replace with function body.


func _on_Cancel_pressed():
	pass # Replace with function body.


func _on_Resolution_selected(id):
	set_scaling(str($Grid/Res.text))


func _on_19_6_selected(id):
	pass # Replace with function body.


func _on_16_10_item_selected(id):
	pass # Replace with function body.


func _on_4_3_item_selected(id):
	pass # Replace with function body.
