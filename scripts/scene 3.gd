extends Node3D

@export var monster: MeshInstance3D

func spawn_monster():
	monster.visible = true
	monster.get_node("Entity2/CollisionShape3D").disabled = false
