extends Control

func _ready():
	pass

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")

func _on_level_3_pressed():
	pass

func _on_level_4_pressed():
	pass
