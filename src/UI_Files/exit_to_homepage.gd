extends Button

func _on_button_down():
	var scene_to_load = "res://UI_files/homepage.tscn"  # Path to the scene you want to switch to
	get_tree().change_scene_to_file(scene_to_load)
