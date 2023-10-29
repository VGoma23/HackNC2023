extends Button

@onready var farm = $"../.."
@onready var plants = $"../../YSortNode/Plants"

func _on_button_down():
	var scene_to_load = "res://UI_files/homepage.tscn"  # Path to the scene you want to switch to
	
	for plant in plants.get_children():
		plant.plantData.DEV_DAY_OFFSET += 1
		
	if farm != null:
		farm.saveAllPlantData()
	get_tree().change_scene_to_file(scene_to_load)
