extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$SpringSFX.play()
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("spring")
		body.JumpPad()

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("rest")
