extends Node


func _ready():
	if not FileAccess.file_exists("user://savestats.save"):
		print("savestats not found")
		return # Error! We don't have a save to load.
	
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
