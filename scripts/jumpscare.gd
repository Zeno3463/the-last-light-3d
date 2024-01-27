extends CanvasLayer

var curr_scene = 1

func jump_scare(change_scene: bool):
	$TextureRect.visible = true
	await get_tree().create_timer(1).timeout
	if change_scene:
		curr_scene += 1
		inventory.clear_inventory()
		get_tree().change_scene_to_file("res://scenes/scene %s.tscn" % [str(curr_scene)])
	else:
		get_tree().reload_current_scene()
	$TextureRect.visible = false
