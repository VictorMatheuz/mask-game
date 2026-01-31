extends CharacterBody2D


@export var velocidade = 300.0
@export var forca_do_pulo = -400.0  # Negativo porque no Godot, PARA CIMA é negativo.

# Pegamos a gravidade padrão configurada no projeto (geralmente 980)
var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# 1. APLICAR GRAVIDADE
	# "is_on_floor()" é uma função mágica do CharacterBody2D.
	# Ela retorna VERDADEIRO se o pé do personagem estiver tocando o chão.
	if not is_on_floor():
		# Se NÃO estiver no chão, aumentamos a velocidade Y (cai mais rápido a cada segundo)
		velocity.y += gravidade * delta

	# 2. PULAR
	# Se apertar o botão de pulo E estiver no chão (para evitar pulo infinito no ar)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		# "ui_accept" geralmente é ESPAÇO ou ENTER por padrão no Godot
		velocity.y = forca_do_pulo

	# 3. MOVIMENTO HORIZONTAL (Esquerda e Direita)
	# Aqui mudamos de "get_vector" para "get_axis".
	# get_axis retorna:
	# -1 se apertar Esquerda
	#  1 se apertar Direita
	#  0 se não apertar nada
	var direcao = Input.get_axis("ui_left", "ui_right")
	
	if direcao:
		# Se tem direção (-1 ou 1), multiplicamos pela velocidade
		velocity.x = direcao * velocidade
		
		# DICA EXTRA: Virar o sprite para o lado certo
		# Se direcao for menor que 0 (esquerda), flip_h (inverter horizontal) é verdadeiro
		# Se for maior que 0 (direita), flip_h é falso.
		# Ajuste "Sprite2D" para o nome exato do nó da sua imagem/animação.
		if $AnimatedSprite2D: # Verifica se existe um nó AnimatedSprite2D
			if direcao < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
	else:
		# Se soltou os botões (direção é 0), desacelera até parar
		velocity.x = move_toward(velocity.x, 0, velocidade)

	# 4. APLICAR TUDO
	move_and_slide()
