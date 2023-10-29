extends Control

func _on_pressed():
	var scene_to_load = "res://Scenes/tooltiptester.tscn"  # Path to the scene you want to switch to
	get_tree().change_scene_to_file(scene_to_load)
