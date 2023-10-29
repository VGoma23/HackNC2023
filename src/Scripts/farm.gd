extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func inspectPlantUI(plant):
	print("pull up plant UI")


func saveAllPlantData():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = $YSortNode/Plants.get_children()
	
	for node in save_nodes:
		var json_string = JSON.stringify(node.get_plant_data_json())
		save_game.store_line(json_string)
		
	
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
		
		print(node_data)
		new_object.global_position = Vector2(node_data["positionX"], node_data["positionY"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "position_x" or i == "position_y":
				continue
			new_object.set(i, node_data[i])