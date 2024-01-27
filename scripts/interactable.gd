extends Area3D

class_name Interactable

@export var key_name: String
@export var destroy_after_interact_with_key: bool
@export var item_to_obtain_after_interact_with_key: String
@export var animate_after_interact_with_key: bool
@export var display_name: bool = true

@export var last_interactable: bool = false

@export var scene_2_spawn_monster = false

func interact():
	if key_name and not inventory.inventory_has_item(key_name):
		inventory.show_interact_text(key_name + " required")
		if scene_2_spawn_monster and get_tree().get_root().get_child(-1).name == "scene 3":
			get_tree().get_root().get_child(-1).spawn_monster()
		return
	if last_interactable:
		get_tree().change_scene_to_file("res://scenes/scene 5.tscn")
	if item_to_obtain_after_interact_with_key:
		inventory.add_to_inventory(item_to_obtain_after_interact_with_key)
		if key_name:
			inventory.fade_in_interact_text("+ " + item_to_obtain_after_interact_with_key + ", - " + key_name)
		else:
			inventory.fade_in_interact_text("+ " + item_to_obtain_after_interact_with_key)
	if animate_after_interact_with_key:
		$AnimationPlayer.play("trigger")
		await $AnimationPlayer.animation_finished
	if scene_2_spawn_monster and inventory.inventory_has_item("Book"):
		get_tree().get_root().get_child(-1).spawn_monster()
	if destroy_after_interact_with_key:
		visible = false
		await get_tree().create_timer(1).timeout
		queue_free()
