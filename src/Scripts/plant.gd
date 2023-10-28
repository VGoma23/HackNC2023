extends StaticBody2D

# adding variables
const Plant = preload("res://Scripts/PlantClass.gd")

var plantData: Plant


func initialize(plant):
	plantData = plant
	# do more stuff based on this

func _ready():
	pass
	
	
func water():
	plantData = Plant.new(plantData.plantName, Time.get_datetime_string_from_system(), plantData.wateringInterval)
	initialize(plantData)

func getPlantData():
	return plantData
