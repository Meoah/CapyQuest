extends Area2D

var switches : int = 0

func _process(_delta):
	if switches == 3:
		switches += 1
		$Success.play()
		$Wall.set_visible(false)
		$CollisionShape2D.set_disabled(true)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.knockback(0.5)
		$Failure.play()
