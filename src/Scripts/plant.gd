extends StaticBody2D

# adding variables
const Plant = preload("res://Scripts/PlantClass.gd")

var plantData: Plant

# how often a plant needs to be watered
func _init():
	pass
	

func initialize(plant):
	plantData = plant
	# do more stuff based on this

func _ready():
	pass
	
