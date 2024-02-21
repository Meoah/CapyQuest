extends Area2D

var triggered : bool = false

func _on_body_entered(body):
	if body.is_in_group("Player") and triggered == false:
		body.add_score(15)
		body.checkpointPos.x = global_position.x
		body.checkpointPos.y = global_position.y
		body.savedDuration = body.duration
		modulate.a = 1
		$AudioStreamPlayer2D.play()
		triggered = true
