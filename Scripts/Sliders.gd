extends HSlider

@export_file("*.ogg") var onHover
@export_file("*.ogg") var onValueChange

func _on_focus_entered():
	global_SoundManager.playSFX(onHover)
	
func _on_mouse_entered():
	global_SoundManager.playSFX(onHover)

func _on_value_changed(value):
	global_SoundManager.playSFX(onValueChange)
