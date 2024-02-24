extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
var health : int = 6
var alive : bool = true
var inMotion : bool = false
var time : float
var jumped : bool = false
var climbing : bool = false
var climbable : bool = false
var descendable : bool = false
var hitStun : float = 0
var isInvuln : float = 0
var BGMSelection : String
var savedScore : int = system_global.score
var savedDuration : float = 0.0
@onready var score_text : Label = get_node("UI/ScoreText")
@onready var heartL = $UI/HeartL
@onready var heartM = $UI/HeartM
@onready var heartR = $UI/HeartR
@onready var checkpointPos = {"x": global_position.x, "y": global_position.y}
var duration : float = 0.0
var minutes : int = 0
var seconds : int = 0
var msec : int = 0
var stopwatch : bool = true
var inv : Array = [0, 0, 0, 0]
var jumpedFromClimb : float = 0.0

func _ready():
	score_text.text = str("Score: ", system_global.score)

func _process(delta):
	#timers
	time = delta
	hitStun -= delta
	isInvuln -= delta
	jumpedFromClimb -= delta
	
	if stopwatch == true:
		duration += delta
	
	@warning_ignore("narrowing_conversion")
	minutes = fmod(duration, 3600) / 60
	@warning_ignore("narrowing_conversion")
	seconds = fmod(duration, 60)
	@warning_ignore("narrowing_conversion")
	msec = fmod (duration, 1) * 100
	$UI/TimeText/Minutes.text = "%02d:" % minutes
	$UI/TimeText/Seconds.text = "%02d:" % seconds
	$UI/TimeText/Milliseconds.text = "%03d" % msec
	
	if alive == false:
		if Input.is_action_just_pressed("jump"):
			reviveAtCheckpoint()
			
	if Input.is_action_just_pressed("reset"):
		system_global.score = savedScore
		get_tree().reload_current_scene()

func _physics_process(delta):
	#Reset
	if hitStun <= 0:
		velocity.x = 0
	if is_on_floor() and alive == true:
		jumped = false
		inMotion = false
	if climbable == false:
		climbing = false
	#Movement
	
	if hitStun > 0:
		if velocity.x > 0 : velocity.x -= gravity * delta
		if velocity.x < 0 : velocity.x += gravity * delta
		if -0.1 < velocity.x and velocity.x < 0.1 : velocity.x = 0
	
	if not is_on_floor() and climbing == false and alive == true:
		velocity.y += gravity * delta
		if $AnimatedSprite2D.get_animation() != "jump": $AnimatedSprite2D.play("jump")
		if jumped == false:
			jumped = true
		if jumped == true and Input.is_action_pressed("jump") == false and velocity.y < 0:
			velocity.y += 2 * gravity * delta
			
	if climbing == true:
		velocity.y = 0
		
	if Input.is_action_pressed("left") and alive == true and hitStun <= 0:
		if climbing == false:
			inMotion = true
			velocity.x -= move_speed
			$AnimatedSprite2D.scale.x = -1
			if is_on_floor():
				if Input.is_action_pressed("right") != true: 
					$AnimatedSprite2D.play("walk")
					footstep()
				if Input.is_action_pressed("right") == true : $AnimatedSprite2D.play("idle")
		if climbing == true:
			velocity.x -= move_speed / 2
			$AnimatedSprite2D.play("climb")
			
	if Input.is_action_pressed("right") and alive == true and hitStun <= 0:
		if climbing == false:
			inMotion = true
			velocity.x += move_speed
			$AnimatedSprite2D.scale.x = 1
			if is_on_floor():
				if Input.is_action_pressed("left") != true: 
					$AnimatedSprite2D.play("walk")
					footstep()
				if Input.is_action_pressed("left") == true : $AnimatedSprite2D.play("idle")
		if climbing == true:
			velocity.x += move_speed / 2
			$AnimatedSprite2D.play("climb")
			
	if Input.is_action_pressed("up") and alive == true and climbable == true and hitStun <= 0 and jumpedFromClimb < 0:
		inMotion = true
		climbing = true
		velocity.y -= move_speed / 2
		$AnimatedSprite2D.play("climb")
		
	if Input.is_action_just_pressed("down") and alive == true and descendable == true and hitStun <= 0 and jumpedFromClimb < 0:
		inMotion = true
		climbing = true
		global_position.y += 1
		$AnimatedSprite2D.play("climb")
		
	if Input.is_action_pressed("down") and alive == true and climbable == true and hitStun <= 0 and jumpedFromClimb < 0:
		inMotion = true
		climbing = true
		velocity.y += move_speed
		$AnimatedSprite2D.play("climb")
		
	if climbing == true:
		if velocity.y == 0 and velocity.x == 0:
			$AnimatedSprite2D.pause()
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
			inMotion = false
			climbing = false
		if climbable == false:
			inMotion = false
			climbing = false
		if Input.is_action_just_pressed("jump"):
			jumped = true
			climbing = false
			jumpedFromClimb = 0.1
			velocity.y = -jump_force
			$SFX/JumpSFX.play()
			$AnimatedSprite2D.play("jump")
		
	if Input.is_action_just_pressed("jump") and is_on_floor() and alive == true and hitStun <= 0:
		inMotion = true
		jumped = true
		velocity.y = -jump_force
		$SFX/JumpSFX.play()
		$AnimatedSprite2D.play("jump")
		
	if inMotion == false and alive == true:
		$AnimatedSprite2D.play("idle")
		
	move_and_slide()
	
	#Death Plane
	if global_position.y > 100:
		take_damage(6)

#TODO func frameFreeze(timeScale, duration):
	#Engine.time_scale = timeScale
	#await(get_tree().create_timer(duration * timeScale).timeout)
	#Engine.time_scale = 1.0

func footstep():
	# TODO: check terrain
	var stepFrame : int = 2
	var stepFrame2 : int = 6
	
	if ($AnimatedSprite2D.frame == stepFrame or $AnimatedSprite2D.frame == stepFrame2) and !$SFX/WalkSFX.playing:
		$SFX/WalkSFX.pitch_scale = randf_range(1.1, 1.25)
		$SFX/WalkSFX.play()

func addInv(item : int):
	for i in 4:
		if inv[i] == 0:
			inv[i] = item
			break
	print(inv)

func useInv(item : int):
	for i in 4:
		if inv[3-i] == item:
			inv[3-i] = 0
			print(inv)
			return(true)
	print(inv)
	return(false)

func knockback(force : float, originX : float, originY : float):
	if isInvuln < 0:
		if (global_position.x - originX) < 0 : velocity.x = -(force * gravity)
		if (global_position.x - originX) > 0 : velocity.x = force * gravity
		if (global_position.y - originY) < 0 : velocity.y = -(force * gravity)
		if (global_position.y - originY) > 0 : velocity.y = force * gravity
		hitStun = force
	else:
		pass

func JumpPad():
	inMotion = true
	jumped = true
	velocity.y = -jump_force*1.5

func invuln(force : float):
	isInvuln = force
	if alive == true:
		for i in 8:
			modulate.a = 0.5
			await get_tree().create_timer((8 * force) * time).timeout
			modulate.a = 1
			await get_tree().create_timer((8 * force) * time).timeout

func take_damage(damage: int):
	if alive == true and isInvuln < 0:
		health -= damage
		if health > 6:
			health = 6
		if health <= 0:
			game_over()
		if damage > 0:
			# TODO frameFreeze(0.1, 0.4)
			invuln(damage * 1)
			$SFX/HitSFX.play()
	else:
		pass

func game_over():
	alive = false
	$AnimatedSprite2D.play("dead")
	velocity.x = 0
	velocity.y = 0
	move_speed = 0
	jump_force = 0
	gravity = 0
	isInvuln = -1
	stopwatch = false
	add_score(-10)
	$UI/GameOverText.visible = true
	
	if $BGM/DawnBGM.is_playing() == true:
		$BGM/DawnBGM._set_playing(false)
		BGMSelection = "dawn"
	if $BGM/DayBGM.is_playing() == true:
		$BGM/DayBGM._set_playing(false)
		BGMSelection = "day"
	if $BGM/DuskBGM.is_playing() == true:
		$BGM/DuskBGM._set_playing(false)
		BGMSelection = "dusk"
	if $BGM/NightBGM.is_playing() == true:
		$BGM/NightBGM._set_playing(false)
		BGMSelection = "night"	
	if $BGM/TwilightBGM.is_playing() == true:
		$BGM/TwilightBGM._set_playing(false)
		BGMSelection = "twilight"	
	$BGM/GameOverBGM._set_playing(true)

func reviveAtCheckpoint():
	alive = true
	invuln(1)
	hitStun = 0
	health = 6
	move_speed = 100.0
	jump_force = 200.0
	gravity = 500.0
	stopwatch = true
	
	if BGMSelection == "dawn":
		$BGM/DawnBGM._set_playing(true)
	if BGMSelection == "day":
		$BGM/DayBGM._set_playing(true)
	if BGMSelection == "dusk":
		$BGM/DuskBGM._set_playing(true)
	if BGMSelection == "night":
		$BGM/NightBGM._set_playing(true)
	if BGMSelection == "twilight":
		$BGM/TwilightBGM._set_playing(true)
	$BGM/GameOverBGM._set_playing(false)
	
	$UI/GameOverText.visible = false
	$AnimatedSprite2D.play("idle")
	
	duration = savedDuration
	global_position.y = checkpointPos.y
	global_position.x = checkpointPos.x

func add_score(amount : int):
	if amount == 10:
		$SFX/CoinSFX.play()
	system_global.score += amount
	score_text.text = str("Score: ", system_global.score)
