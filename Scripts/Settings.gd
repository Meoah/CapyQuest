extends Control

func _ready():
	$GridContainer/BGM.grab_focus()
	$GridContainer/BGM.set_value_no_signal(global_SaveData.gameSettings_BGM)
	$GridContainer/SFX.set_value_no_signal(global_SaveData.gameSettings_SFX)
	$GridContainer/OptionButton.selected = global_SaveData.gameSettings_WindowMode

func _on_bgm_value_changed(value):
	global_SaveData.gameSettings_BGM = value
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_sfx_value_changed(value):
	global_SaveData.gameSettings_SFX = value
	AudioServer.set_bus_volume_db(2, linear_to_db(value))

func _on_back_pressed():
	get_parent()._ready()
	queue_free()

func _on_option_button_item_selected(index):
	global_SaveData.gameSettings_WindowMode = index
	if index == 0 : get_window().set_mode(Window.MODE_WINDOWED)
	if index == 1 : get_window().set_mode(Window.MODE_FULLSCREEN)
	if index == 2 : get_window().set_mode(Window.MODE_EXCLUSIVE_FULLSCREEN)
