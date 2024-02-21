extends Area2D

var obtained : bool = false

func _on_body_entered(body):
	if body.is_in_group("Player") and obtained == false:
		if body.useInv("Key"):
			$Success.play()
			modulate.a = 0
			obtained = true
			await get_tree().create_timer(1).timeout
			queue_free()
		else:
			body.knockback(0.5)
			$Failure.play()
