extends CharacterBody3D

@export var player: Player

func _physics_process(delta):
	var dir = player.global_position - global_position
	dir = -dir
	dir.y = 0
	var rotation = Basis().looking_at(dir)
	global_transform.basis = rotation
	velocity = (player.position - position).normalized()
	velocity.y = 0
	move_and_slide()


func _on_area_3d_body_entered(body):
	if body is Player:
		Jumpscare.jump_scare(false)
