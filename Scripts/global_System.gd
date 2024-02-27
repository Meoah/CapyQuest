extends Node

var score : int = 0

func _ready():
	# Always runs even when paused.
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Load Settings
	setBGM(global_SaveData.gameSettings_BGM)
	setSFX(global_SaveData.gameSettings_SFX)
	setWindowMode(global_SaveData.gameSettings_WindowMode)

func saveHiScore(submittedScore : int, level : int):
	if submittedScore > global_SaveData.levelHiScore[level] : global_SaveData.levelHiScore[level] = submittedScore

func setBGM(setting : float):
	AudioServer.set_bus_volume_db(1, linear_to_db(setting))
	
func setSFX(setting : float):
	AudioServer.set_bus_volume_db(2, linear_to_db(setting))
	
func setWindowMode(setting : int):
	if setting == 0 : get_window().set_mode(Window.MODE_WINDOWED)
	if setting == 1 : get_window().set_mode(Window.MODE_FULLSCREEN)
	if setting == 2 : get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)
