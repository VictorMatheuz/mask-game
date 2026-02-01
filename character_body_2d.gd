extends CharacterBody2D


@export var velocidade = 80.0
@export var forca_do_pulo = -200.0
var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
var ultima_direcao = 1

func _physics_process(delta):
	# 1. GRAVIDADE
	if not is_on_floor():
		velocity.y += gravidade * delta

	# 2. PULAR
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = forca_do_pulo

	# 3. MOVIMENTO HORIZONTAL
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis:
		velocity.x = input_axis * velocidade
		
		# Guardamos para onde ele está olhando
		if input_axis > 0:
			ultima_direcao = 1
			$Sprite2D.flip_h = false # Ou Sprite2D
		else:
			ultima_direcao = -1
			$Sprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
	
	move_and_slide()

func _on_area_visao_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
