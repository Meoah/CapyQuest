extends Area2D

var pressed : bool = false

func _on_body_entered(body):
	if body.is_in_group("Player") and pressed == false:
		pressed = true
		get_parent().switches += 1
		$Up.set_visible(false)
		$Down.set_visible(true)
		$AudioStreamPlayer2D.play()
