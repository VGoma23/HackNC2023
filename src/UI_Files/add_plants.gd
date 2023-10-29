extends MenuButton
@onready var textEdit = $"../../TextEdit"
func _ready():
	get_popup().index_pressed.connect(signal_id)
	
signal send_veggie(plant, cuteName)


func signal_id(id):
	var plant = get_popup().get_item_text(id)
	var cuteName = textEdit.text
	if textEdit.text == "Name Your Plant":
		cuteName = null
	send_veggie.emit(plant, textEdit.text)
	textEdit.text = ""
	print(plant)

	
