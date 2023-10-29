extends Control

func _on_button_down():
	var scene_to_load = "res://UI_Files/plant_data.tscn"
	get_tree().change_scene_to_file(scene_to_load)
	var asp = $"../../../AudioStreamPlayer"
	asp.play()
