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
	
func _physics_process(delta):
	if not isPlayerInArea:
		return
	if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
		print("watering")
		water()
	
	
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



func _on_interaction_area_body_entered(body):
	pass



func _on_interaction_area_body_exited(body):
	pass
	
