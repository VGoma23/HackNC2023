extends Node2D


var Plant = preload("res://Scripts/PlantClass.gd")
var previousPosition: Vector2


@onready var addPlantMenu = $CanvasLayer/add_plants

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()
	waterStreak()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func inspectPlantUI(plant):
	$CanvasLayer/Node2D.show_menu(plant)
	print("pull up plant UI")


func saveAllPlantData():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = $YSortNode/Plants.get_children()
	
	for node in save_nodes:
		var json_string = JSON.stringify(node.get_plant_data_json())
		save_game.store_line(json_string)
		
	
	var save_stats = FileAccess.open("user://savestats.save", FileAccess.WRITE)
	var statController = $StatTracker
	save_stats.store_line(JSON.stringify(statController.toJSON()))
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	var save_nodes = $YSortNode/Plants.get_children()
	for i in save_nodes:
		i.queue_free()
	
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load("res://Elements/plant.tscn").instantiate()
		$YSortNode/Plants.add_child(new_object)
		
		var plantData = Plant.new()
		
		new_object.global_position = Vector2(node_data["positionX"], node_data["positionY"])
		
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent":
				continue
			plantData.set(i, node_data[i])
		new_object.initialize(plantData)
		var save_stats = FileAccess.open("user://savegame.save", FileAccess.READ)
		
	
	
	
	
	if not FileAccess.file_exists("user://savestats.save"):
		print("savestats not found")
		return # Error! We don't have a save to load.
	var stattrack = $StatTracker
	stattrack.set_name("DeadStatTracker")
	stattrack.queue_free()
	
	
	var save_stats = FileAccess.open("user://savestats.save", FileAccess.READ)
	###### ALL STUFF FROM WHILE LOOP
	var json_string = save_stats.get_line()
	# Creates the helper class to interact with JSON
	var json = JSON.new()
	# Check if there is any error while parsing the JSON string, skip in case of failure
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	# Get the data from the JSON object
	var node_data = json.get_data()
	
	# Firstly, we need to create the object and add it to the tree and set its position.
	var new_object = load("res://stat_tracker.tscn").instantiate()
	add_child(new_object)
	new_object.set_name("StatTracker")
	for i in node_data.keys():
		if i == "filename" or i == "parent":
			continue
		new_object.set(i, node_data[i])
	######## ALL STUFF FROM WHILE LOOP

func _on_player_create_plant(_position):
	

	addPlantMenu.show_menu()
	previousPosition = _position



# input stuff raaahhhh

var isPressed = false
var initialPos = null
var joystickInputVec = Vector2.ZERO
const maxLength = 100 # extremely subject to change

@onready var player = $YSortNode/Player

func _unhandled_input(event):
	if (event is InputEventScreenTouch):
		if (!isPressed && event.pressed):
			isPressed = true
			player.touchMovement = true
			initialPos = event.position
		elif (isPressed && !event.pressed):
			isPressed = false
			player.touchMovement = false
			initialPos = null
			joystickInputVec = Vector2.ZERO
			player.input_vector = Vector2.ZERO
#		print(isPressed)
	elif (event is InputEventScreenDrag):
		joystickInputVec = event.position - initialPos
		joystickInputVec = joystickInputVec.limit_length(maxLength) / maxLength
#		print(joystickInputVec)
		player.input_vector = joystickInputVec


func _on_add_plants_send_veggie(veggie_name, cuteName):
	var plantData = Plant.new(veggie_name, Time.get_datetime_string_from_system(), previousPosition.x, previousPosition.y, 0, cuteName)
	var new_plant = load("res://Elements/plant.tscn").instantiate()
	$YSortNode/Plants.add_child(new_plant)
	new_plant.initialize(plantData)
	saveAllPlantData()
	$StatTracker.plantsPlanted += 1
	print("plant made")

func waterStreak():
	$StatTracker.daysPlayed += 1
	var plants = $YSortNode/Plants.get_children()
	for i in plants:
		if i.plantData.isStreakBroken():
			$StatTracker.waterStreak = 0
			print("reset streak")
			return
	$StatTracker.waterStreak += 1
	print("add streak")
