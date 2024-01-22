extends CanvasLayer

var items: Array[String] = []

func add_to_inventory(item: String):
	items.append(item)
	

func delete_from_inventory(item_name: String):
	items = items.reduce(func(item): return item.item_name != item_name)
	
func inventory_has_item(item_name: String):
	return items.has(item_name)
	
func show_interact_text(item_name: String):
	$CenterContainer/Label.text = item_name
	$CenterContainer.modulate = Color.WHITE

func fade_in_interact_text(text: String):
	$CenterContainer.modulate = Color.WHITE
	$CenterContainer/Label.text = text
	$AnimationPlayer.play("new_animation")
	await $AnimationPlayer.animation_finished
	$CenterContainer.modulate = Color.TRANSPARENT

func hide_interact_text():
	$CenterContainer.modulate = Color.TRANSPARENT
