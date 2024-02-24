extends Control

func _ready():
	if !$BGMTitle.playing : $BGMTitle.play()
	$Buttons/StartGameButton.grab_focus()
	$Buttons.visible = true

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_level_select_button_pressed():
	$Buttons.visible = false
	var levelSelect = load("res://Scenes/Menus/LevelSelect.tscn").instantiate()
	get_tree().current_scene.add_child(levelSelect)

func _on_credits_button_pressed():
	print("This is where I'd have a credits screen IF I HAD ONE")

func _on_quit_button_pressed():
	get_tree().quit()
