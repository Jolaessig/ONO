extends Control

func _input(event):
	if event.is_action_pressed("jump_button"):
		get_tree().change_scene_to_file("res://Levels/Level_1.tscn")
