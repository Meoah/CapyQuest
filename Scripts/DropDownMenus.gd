extends OptionButton

@export_file("*.ogg") var onHover
@export_file("*.ogg") var onSelect

func _on_focus_entered():
	global_SoundManager.playSFX(onHover)
	
func _on_mouse_entered():
	global_SoundManager.playSFX(onHover)
	
func _on_item_selected(_index):
	global_SoundManager.playSFX(onSelect)

func _on_item_focused(index):
	global_SoundManager.playSFX(onHover)
