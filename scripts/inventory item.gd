extends Area3D

class_name InventoryItem

@export var display_name = true

func interact():
	inventory.add_to_inventory(name)
	inventory.fade_in_interact_text("+ " + name)
	visible = false
	await get_tree().create_timer(2).timeout
	queue_free()
