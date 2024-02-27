extends Button

@export_file("*.ogg") var onHover
@export_file("*.ogg") var onSelect

func _on_focus_entered():
	global_SoundManager.playSFX(onHover)
	
func _on_mouse_entered():
	global_SoundManager.playSFX(onHover)

func _on_pressed():
	global_SoundManager.playSFX(onSelect)
