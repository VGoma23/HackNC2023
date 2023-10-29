extends MenuButton

func _ready():
	get_popup().index_pressed.connect(signal_id)
	
signal send_veggie
func signal_id(id):
	var plant = get_popup().get_item_text(id)
	send_veggie.emit(plant)
	print(plant)

	
