extends Control

func _ready():
	$VBoxContainer2/Back.grab_focus()

func _on_back_pressed():
	get_parent().backWindow()
	queue_free()
