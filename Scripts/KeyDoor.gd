extends Area2D

var obtained : bool = false

func _on_body_entered(body):
	if body.is_in_group("Player") and obtained == false:
		if body.useInv(1):
			$Success.play()
			modulate.a = 0
			obtained = true
			$StaticBody2D/CollisionShape2D.set_disabled(true)
			await get_tree().create_timer(1).timeout
			queue_free()
		else:
			body.knockback(0.5, global_position.x, global_position.y)
			$Failure.play()
