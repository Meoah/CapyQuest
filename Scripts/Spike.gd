extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(2)
