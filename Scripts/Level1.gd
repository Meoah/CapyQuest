extends Node2D

@export_file("*.mp3") var BGM

func _ready():
	global_System.score = 0
	global_SoundManager.clearAllBGM()
	global_SoundManager.playBGM(BGM)
