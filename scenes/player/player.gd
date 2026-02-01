extends CharacterBody2D

@onready var ataque = preload("res://scenes/player/tomate_ataque.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	if direction == 1:
		$AnimatedSprite2D.play("move_right")
		$flip.scale.x = 1
	elif direction == -1:
		$AnimatedSprite2D.play("move_left")
		#$flip/ShotPosition.position = Vector2(-9,0)
		$flip.scale.x = -1
	elif direction == 0: 
		
		$AnimatedSprite2D.stop()
	
	if Input.is_action_just_pressed("ataque"):
		
		var k = ataque.instantiate()
		
		k.global_position = $flip/ShotPosition.global_position
		print(k.global_position)
		k.vel = $flip.scale.x
		get_parent().add_child(k)
		
		
	move_and_slide()
		
		
