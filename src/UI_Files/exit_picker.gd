extends Button

signal hide_self

func _on_button_down():
	var scene_to_load = "res://farm.tscn"  # Path to the scene you want to switch to
	hide_self.emit()
