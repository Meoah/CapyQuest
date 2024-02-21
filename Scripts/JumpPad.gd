extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$SpringSFX.play()
		$AnimatedSprite2D.play("spring")
		body.JumpPad()
