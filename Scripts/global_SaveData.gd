extends Node

# Game Settings
var gameSettings_BGM : float = 0.5
var gameSettings_SFX : float = 0.5
var gameSettings_WindowMode : int = 0

# Level Scores
var levelHiScore : Array

func _ready():
	levelHiScore.resize(10)
	levelHiScore.fill(0)
