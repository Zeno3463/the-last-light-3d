extends Area3D

class_name Interactable

@export var key_name: String
@export var destroy_after_interact_with_key: bool
@export var item_to_obtain_after_interact_with_key: String
@export var animate_after_interact_with_key: bool
@export var display_name: bool = true

func interact():
	if key_name and not inventory.inventory_has_item(key_name):
		inventory.show_interact_text(key_name + " required")
		return
	if item_to_obtain_after_interact_with_key:
		inventory.add_to_inventory(item_to_obtain_after_interact_with_key)
		if key_name:
			inventory.fade_in_interact_text("+ " + item_to_obtain_after_interact_with_key + ", - " + key_name)
		else:
			inventory.fade_in_interact_text("+ " + item_to_obtain_after_interact_with_key)
	if animate_after_interact_with_key:
		$AnimationPlayer.play("trigger")
		await $AnimationPlayer.animation_finished
	if destroy_after_interact_with_key:
		visible = false
		await get_tree().create_timer(1).timeout
		queue_free()
