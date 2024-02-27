extends Node

var score : int = 0

func _ready():
	# Always runs even when paused.
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	pass
