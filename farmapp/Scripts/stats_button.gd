extends Button

var tooltip = preload("res://Scenes/tooltip.tscn")

func _on_button_down():
	var tool_tip_instance = tooltip.instantiate()
	add_child(tool_tip_instance)
