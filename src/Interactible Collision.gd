extends CollisionShape2D

const SCALE = 4

@onready var highlight = $"16x16Highlight"

func _physics_process(delta):
	var parentPos = Vector2i(get_parent().global_position)
	global_position.x = parentPos.x - (parentPos.x % (16 * SCALE)) + (8 * SCALE)
	global_position.y = parentPos.y - (parentPos.y % (16 * SCALE)) + (8 * SCALE)
