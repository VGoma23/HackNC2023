extends StaticBody2D

# adding variables
const Plant = preload("res://Scripts/PlantClass.gd")

var plantData: Plant
@onready var sprite = $Sprite2D

var isPlayerInArea = false
signal playerEnteredPlantArea(plant)
signal playerExitedPlantArea(plant)



func initialize(plant):
	plantData = plant
	# do more stuff based on this
	if plantData.isThirsty():
		sprite.modulate = "c56204"
	else:
		sprite.modulate = "AAAAAA"
	
func _ready():
	pass
	
func water():
	plantData = Plant.new(plantData.plantName, Time.get_datetime_string_from_system(), plantData.wateringInterval)
	initialize(plantData)

func getPlantData():
	return plantData


func _on_interaction_area_area_entered(area):
	print("area entered!")
	isPlayerInArea = true


func _on_interaction_area_area_exited(area):
	isPlayerInArea = false
	print("area exited!")
