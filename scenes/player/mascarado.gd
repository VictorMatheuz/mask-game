extends CharacterBody3D
var animation_frame = 0
var facing = 0
const FRAMES = 3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	update_facing(input_dir)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func update_facing(direction):
	# Start and Stop Animation based on input
	if direction != Vector2(0,0):
		$AnimatedSprite3D.play("frame")
	else:
		$AnimatedSprite3D.stop()
		animation_frame = 1
	
	# Set Facing and Horizontal Flip depending on input direction
	if direction.x == -1:
		
		print("move left")
		$AnimatedSprite3D.play("move_left")
	elif direction.x == 1:
		
		print("move right")
		$AnimatedSprite3D.play("move_right")
	elif direction.y == 1:
		
		print("move_down")
		$AnimatedSprite3D.play("move_down")
	elif direction.y == -1:
		
		print("move up")
		$AnimatedSprite3D.play("move_up")
	
