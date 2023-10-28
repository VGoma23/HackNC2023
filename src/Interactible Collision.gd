extends CollisionShape2D

func _physics_process(delta):
	var parentPos = Vector2i(get_parent().global_position)
	global_position.x = parentPos.x - (parentPos.x % 16) + 8
	global_position.y = parentPos.y - (parentPos.y % 16) + 8
