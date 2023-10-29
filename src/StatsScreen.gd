extends Node


func _ready():
	if not FileAccess.file_exists("user://savestats.save"):
		print("savestats not found")
		return # Error! We don't have a save to load.
	
	var save_stats = FileAccess.open("user://savestats.save", FileAccess.READ)
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
	var statTracker = load("res://stat_tracker.tscn").instantiate()
	add_child(statTracker)
	statTracker.set_name("StatTracker")
	for i in node_data.keys():
		if i == "filename" or i == "parent":
			continue
		statTracker.set(i, node_data[i])
	
	var container = $Stats/Container
	container.get_child(0).get_child(1).text = str(statTracker.plantsPlanted)
	container.get_child(1).get_child(1).text = str(statTracker.plantsWatered)
	container.get_child(2).get_child(1).text = str(statTracker.daysPlayed)
	container.get_child(3).get_child(1).text = str(statTracker.waterStreak)
