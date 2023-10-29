extends StaticBody2D

# adding variables
const Plant = preload("res://Scripts/PlantClass.gd")

signal playerEnteredPlantArea(plant)
signal playerExitedPlantArea(plant)


var plantData: Plant

@onready var sprite = $Sprite2D
@onready var farm = $"../../.."
@onready var interactionArea = $InteractionArea


signal updateLabel(plantName)

var isPlayerInArea = false

signal expandPlantUI(plant)

func _ready():
	expandPlantUI.connect(farm.inspectPlantUI)
	updateLabel.connect($"../../../CanvasLayer/Label".setText)
	

func initialize(plant):
	plantData = plant
 
	# do more stuff based on this
	if plantData.isThirsty():
		sprite.modulate = "c56204"
	else:
		sprite.modulate = "AAAAAA"
		
	interactionArea.plantName = plantData.cuteName
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
	plantData = Plant.new(plantData.plantName, Time.get_datetime_string_from_system(), global_position.x, global_position.y, plantData.numTimesWatered + 1, plantData.cuteName)
	initialize(plantData)
	farm.saveAllPlantData()
	var asp = $AudioStreamPlayer
	asp.play()
	
	$"../../../StatTracker".plantsWatered += 1
	

func getPlantData():
	return plantData


func _on_interaction_area_area_entered(area):
	updateLabel.emit(plantData.cuteName)
	print("area entered!")
	isPlayerInArea = true

func _on_interaction_area_area_exited(area):
	updateLabel.emit("")
	isPlayerInArea = false
	print("area exited!")


func get_plant_data_json():
	if plantData:
		return plantData.toJSON()


func _on_interaction_area_body_entered(body):
	pass



func _on_interaction_area_body_exited(body):
	pass
	
