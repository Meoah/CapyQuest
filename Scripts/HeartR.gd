extends AnimatedSprite2D

var bob_height : float = 5.0
var bob_speed : float = 1.0
var d : float
@onready var start_y : float = global_position.y
var t : float = 0.5

func _process(delta):
	t += delta
	if get_parent().get_parent().health > 4:
		d = (sin(t * bob_speed) + 1)
		global_position.y = start_y + (d * bob_height)
		if get_parent().get_parent().health == 5:
			play("Half")
		if get_parent().get_parent().health >= 6:
			play("Full")
	else:
		play("Empty")
		var savedPos = global_position.y
		global_position.y = savedPos
