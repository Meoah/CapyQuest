extends Control

@export_file("*.mp3") var BGM

func _ready():
	global_SoundManager.clearAllBGM()
	global_SoundManager.playBGM(BGM)
	$Title.grab_focus()
	
func _on_title_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/Title.tscn")


func _on_quit_pressed():
	get_tree().quit()
