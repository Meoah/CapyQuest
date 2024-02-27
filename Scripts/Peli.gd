extends Area2D

@export var move_speed : float = 30.0
@export var move_dir : Vector2

var timer : float = 0
var timerSet : bool = false
var start_pos : Vector2
var target_pos : Vector2
var rotationSpeed : float = 2.0

func _ready():
	start_pos = global_position
	target_pos = start_pos + move_dir
	
func _physics_process(delta):
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	timer -= delta
	
	if (global_position.x - get_node("/root/Main/Jeff").global_position.x) < 0:
		$AnimatedSprite2D.flip_h = false
	if (global_position.x - get_node("/root/Main/Jeff").global_position.x) > 0:
		$AnimatedSprite2D.flip_h = true
	
	#rotateToTarget(get_node("/root/Main/Jeff"), delta)
	
	if global_position == target_pos and timerSet == false:
		timerSet = true
		timer = randf_range(2,4)
	
	if global_position == target_pos and timer < 0:
		if global_position == start_pos:
			$PeliSFX.play()
			target_pos = start_pos + move_dir
			timerSet = false
		else:
			$PeliSFX.play()
			target_pos = start_pos
			timerSet = false

func _process(delta):
	var overlapping_bodies = get_overlapping_bodies()

	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			body.knockback(0.35, global_position.x, global_position.y)
			if body.checkInvuln() == false : body.frameFreeze(0.1, 0.4)
			body.take_damage(2)
	
func rotateToTarget(target, delta):
	var direction = target.global_position - global_position
	var angleTo = $AnimatedSprite2D.transform.x.angle_to(direction)
	$AnimatedSprite2D.rotate(sign(angleTo) * min(delta * rotationSpeed, abs(angleTo)))
	if fposmod($AnimatedSprite2D.get_rotation_degrees() - 90, 360) < 180:
		$AnimatedSprite2D.flip_v = true
	if fposmod($AnimatedSprite2D.get_rotation_degrees() - 90, 360) > 180:
		$AnimatedSprite2D.flip_v = false
