extends Area2D

@export var move_speed : float = 30.0
@export var move_dir : Vector2

var timer : float = 0
var timerSet : bool = false
var start_pos : Vector2
var target_pos : Vector2

func _ready():
	start_pos = global_position
	target_pos = start_pos + move_dir

func _process(delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	timer -= delta
	
	if global_position.x - target_pos.x > 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.scale.x = -1
	elif global_position.x - target_pos.x < 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.scale.x = 1
	else:
		$AnimatedSprite2D.play("idle")
	
	if global_position == target_pos and timerSet == false:
		timerSet = true
		timer = randf_range(2,4)
	
	if global_position == target_pos and timer < 0:
		if global_position == start_pos:
			$CrocSFX.play()
			target_pos = start_pos + move_dir
			timerSet = false
		else:
			$CrocSFX.play()
			target_pos = start_pos
			timerSet = false
			
	var overlapping_bodies = get_overlapping_bodies()

	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			body.knockback(0.35, global_position.x, global_position.y)
			if body.checkInvuln() == false : body.frameFreeze(0.1, 0.4)
			body.take_damage(2)
