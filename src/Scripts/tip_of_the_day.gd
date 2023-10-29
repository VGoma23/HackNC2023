extends Node2D

@onready var animationPlayer = $AnimationPlayer
@onready var label = $RichTextLabel

var tips = ["Did you know that apples, cherries, and peaches are part of the rose (Rosaceae) family?",
"Did you know that okra, cotton, cacao, and hibiscus are all part of the Malvaceae family?",
"Strawberries are the only fruit that holds seeds on their exterior.",
"Peanuts aren’t actually nuts—they’re legumes that are closer to beans and lentils.",
"You might know that tomatoes are fruits, but did you know that avocados and pumpkins are also fruits?",
"Vanilla beans are actually pods from an Orchid.",
"Herbs, such as Basil, Rosemary, and Mint, function as natural insect repellent.",
]

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	label.text = tips[rng.randi_range(0, len(tips)-1)]
	

func _on_timer_timeout():
	animationPlayer.play("fade_out")
