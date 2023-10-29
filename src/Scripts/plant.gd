extends StaticBody2D

# adding variables
const Plant = preload("res://Scripts/PlantClass.gd")

signal playerEnteredPlantArea(plant)
signal playerExitedPlantArea(plant)


var plantData: Plant

@onready var sprite = $Sprite2D
@onready var farm = $"../../.."


var isPlayerInArea = false

signal expandPlantUI(plant)

func _ready():
	expandPlantUI.connect(farm.inspectPlantUI)
	print(global_position)
	initialize(Plant.new("test", "2022-10-1111:11:11", 3, global_position.x, global_position.y)) # TODO replace
	

func initialize(plant):
	plantData = plant
	
	# do more stuff based on this
	if plantData.isThirsty():
		sprite.modulate = "c56204"
	else:
		sprite.modulate = "AAAAAA"
	global_position.x = plant.positionX
	global_position.y = plant.positionY
	
func _physics_process(delta):
	if not isPlayerInArea:
		return
	
	if (Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept")) and plantData.isThirsty():
		print("watering")
		water()
	elif (Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept")):
		expandPlantUI.emit(plantData)
	
func water():
	plantData = Plant.new(plantData.plantName, Time.get_datetime_string_from_system(), plantData.wateringInterval, global_position.x, global_position.y, plantData.numTimesWatered + 1, plantData.cuteName)
	initialize(plantData)
	farm.saveAllPlantData()

func getPlantData():
	return plantData


func _on_interaction_area_area_entered(area):
	print("area entered!")
	isPlayerInArea = true

func _on_interaction_area_area_exited(area):
	isPlayerInArea = false
	print("area exited!")


func get_plant_data_json(): # TODO
	return plantData.toJSON()


func _on_interaction_area_body_entered(body):
	pass



func _on_interaction_area_body_exited(body):
	pass
	
