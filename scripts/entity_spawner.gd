extends Area3D

func _on_body_entered(body):
	if body is Player:
		$Entity.visible = true
		$Entity/Entity/CollisionShape3D.set_deferred("disabled", false)
