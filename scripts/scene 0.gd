extends CanvasLayer

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/scene 1.tscn")

func _on_button_mouse_entered():
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer/VBoxContainer/Button, "modulate", Color.TRANSPARENT, 0.1)

func _on_button_mouse_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer/VBoxContainer/Button, "modulate", Color.WHITE, 0.1)
