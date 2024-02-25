extends Control

func _ready():
	if !$BGMEnding.playing : $BGMEnding.play()

func _on_title_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/Title.tscn")


func _on_quit_pressed():
	get_tree().quit()
