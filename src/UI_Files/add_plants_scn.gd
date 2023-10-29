extends Node2D
signal send_veggie(veggie_name, cuteName)

func _ready():
	visible = false

func show_menu():
	visible = true

func _on_add_button_send_veggie(plant, cuteName):
	send_veggie.emit(plant, cuteName)
	self.visible = false


func _on_home_hide_self():
	self.visible = false
