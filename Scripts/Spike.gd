extends Area2D

func _process(_delta):
	var overlapping_bodies = get_overlapping_bodies()

	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			body.knockback(0.1, global_position.x, global_position.y)
			body.take_damage(1)
