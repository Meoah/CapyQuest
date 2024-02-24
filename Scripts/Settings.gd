extends Control

func _ready():
	$VBoxContainer2/Back.grab_focus()
	if ProjectSettings.get_setting("display/window/size/mode") == 0 : $Window/OptionButton.selected = 0
	if ProjectSettings.get_setting("display/window/size/mode") == 3 : $Window/OptionButton.selected = 1
	if ProjectSettings.get_setting("display/window/size/mode") == 4 : $Window/OptionButton.selected = 2

func _on_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_sfx_value_changed(value):
	if !$TestSFX.playing : $TestSFX.play()
	AudioServer.set_bus_volume_db(2, linear_to_db(value))

func _on_back_pressed():
	get_parent().backWindow()
	queue_free()


func _on_option_button_item_selected(index):
	if index == 0: 
		ProjectSettings.set_setting("display/window/size/borderless", false)
		ProjectSettings.set_setting("display/window/size/mode", 0)
		get_window().set_mode(Window.MODE_WINDOWED)
	if index == 1:
		ProjectSettings.set_setting("display/window/size/borderless", true)
		ProjectSettings.set_setting("display/window/size/mode", 3)
		get_window().set_mode(Window.MODE_FULLSCREEN)
	if index == 2:
		ProjectSettings.set_setting("display/window/size/borderless", true)
		ProjectSettings.set_setting("display/window/size/mode", 4)
		get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)
