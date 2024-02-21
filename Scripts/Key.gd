extends Area2D

var bob_height : float = 10.0
var bob_speed : float = 2.0
var d : float
var obtained : bool = false

@onready var start_y : float = global_position.y
var t : float = 0.0

func _process(delta):
	t += delta
	
	d = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (d * bob_height)
	

func _on_body_entered(body):
	if body.is_in_group("Player") and obtained == false:
		body.addInv("Key")
		$AudioStreamPlayer2D.play()
		modulate.a = 0
		obtained = true
		await get_tree().create_timer(1).timeout
		queue_free()
