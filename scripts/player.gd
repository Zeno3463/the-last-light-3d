extends CharacterBody3D

class_name Player

var speed
const WALK_SPEED = 4.0
const SPRINT_SPEED = 6.0
const JUMP_VELOCITY = 3.5
const SENSITIVITY = 0.001

const BOB_FREQ = 3.0
const BOB_AMP = 0.04
var t_bob = 0.0

var expelling = false
var expel_val = Vector3.ZERO

@export var door: Area3D
var jump_scare_trigger = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8

func _unhandled_input(event):
	if event.as_text() == "Left Mouse Button" and get_tree().current_scene.name != "Start":
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$Head.rotate_y(-event.relative.x * SENSITIVITY)
		$Head/Camera3D.rotate_x(-event.relative.y * SENSITIVITY)
		$Head/Camera3D.rotation.x = clamp($Head/Camera3D.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if Input.is_action_just_pressed("interact"):
		for area in $Head/Camera3D/Area3D.get_overlapping_areas():
			if area is InventoryItem:
				area.interact()
			if area is Interactable:
				area.interact()
			if area.name == "Door" and jump_scare_trigger:
				await get_tree().create_timer(0.9).timeout
				Jumpscare.jump_scare(true)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else: speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if expelling:
		input_dir = expel_val
	var direction = ($Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	t_bob += delta * velocity.length() * float(is_on_floor())
	$Head/Camera3D.transform.origin = _headbob(t_bob)

	move_and_slide()

func _headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _on_area_3d_area_entered(area):
	if area is InventoryItem or area is Interactable:
		if area.display_name:
			inventory.show_interact_text(area.name)

func _on_area_3d_area_exited(area):
	if area is InventoryItem or area is Interactable:
		inventory.hide_interact_text()

func _on_area_3d_2_body_entered(body):
	if body.name == "Entity":
		await get_tree().create_timer(0.1).timeout
		door.get_node("AnimationPlayer").play("RESET")
		if get_tree().current_scene.name == "scene 1":
			jump_scare_trigger = true
		elif get_tree().current_scene.name == "scene 2":
			body.get_parent().get_parent().queue_free()
	if body.name == "Entity2":
		await get_tree().create_timer(0.1).timeout
		Jumpscare.jump_scare(true)
