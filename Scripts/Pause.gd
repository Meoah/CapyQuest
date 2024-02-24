extends Control

func _ready():
	hide()

func backWindow():
	show()
	$PauseMenuUI.show()
	$PauseMenuUI/Buttons/Continue.grab_focus()

func pause():
	get_tree().paused = true
	$PauseMenuUI/Buttons/Continue.grab_focus()
	show()

func _on_continue_pressed():
	hide()
	get_tree().paused = false

func _on_settings_pressed():
	$PauseMenuUI.hide()
	var settings = load("res://Scenes/Menus/Settings.tscn").instantiate()
	add_child(settings)

func _on_title_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/Title.tscn")

func _on_quit_pressed():
	get_tree().quit()
