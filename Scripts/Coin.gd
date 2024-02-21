extends Area2D

var bob_height : float = 5.0
var bob_speed : float = 5.0
var d : float

@onready var start_y : float = global_position.y
var t : float = 0.0

func _process(delta):
	t += delta
	
	d = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (d * bob_height)
	

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(-1)
		body.add_score(10)
		queue_free()
