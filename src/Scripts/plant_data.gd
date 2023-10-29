extends Node2D

@onready var title = $Background/ColorRect/UI/Label
@onready var plantImage = $Background/ColorRect/UI/ItemList

@onready var personalStatsLabel = $Background/ColorRect/UI/PanelContainer/Label
@onready var plantStatsLabel = $Background/ColorRect/UI/PanelContainer2/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func show_menu(plant):
	visible = true
	title.text = plant.cuteName
	plantImage.get_theme_stylebox("panel", "" ).set_texture(load(plant.plantImagePath))
	personalStatsLabel.text = "Times watered: " + str(plant.numTimesWatered)
	plantStatsLabel.text = "Plant Name: " + plant.plantName + "\n" + "Recommended Sun Coverage: " + plant.sunCoverage + "\n" + "Days to Maturity: " + str(plant.daysToMaturity) + "\n" + "Water every " + str(plant.wateringInterval) + " days"
	


func _on_homepage_button_down():
	visible = false

