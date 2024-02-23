extends Node2D

@export var requiredSwitches : int = 0
@export var knockback : bool = true

func _process(_delta):
	if get_parent().switches == requiredSwitches:
		requiredSwitches = -1
		$"../Success".play()
		$Sprites.set_visible(false)
		$CollisionShape2D.set_disabled(true)

func _on_body_entered(body):
	if body.is_in_group("Player") and knockback == true:
		body.knockback(0.5)
		$"../Failure".play()
