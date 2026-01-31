extends CharacterBody2D

# --- CONFIGURAÇÕES ---
@export var velocidade = 80.0
@export var gravidade = 980.0
@export var vida_inimigo = 3  # Ele aguenta 3 tomatadas

# 1 = Direita, -1 = Esquerda
var direcao = 1 

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravidade * delta
	
	velocity.x = direcao * velocidade
	move_and_slide()
	
	if is_on_wall():
		mudar_direcao()

func mudar_direcao():
	# Inverte a direção matemática
	direcao = direcao * -1
	
	# 1. Vira o Sprite (Imagem do corpo)
	if $Sprite2D:
		$Sprite2D.flip_h = (direcao < 0)
	
	# 2. Vira o Cone de Visão (NOVIDADE)
	# Como o cone é filho do inimigo, se usarmos scale.x nele,
	# ele espelha o desenho para o outro lado.
	# Se direção é 1 (direita), scale é 1. Se é -1 (esquerda), scale é -1.
	if $AreaVisao:
		$AreaVisao.scale.x = direcao

# --- COLISÃO FÍSICA (Tocou no corpo) ---
func _on_area_dano_body_entered(body):
	machucar_player(body)

# --- COLISÃO VISUAL (Entrou no cone de visão) ---
# Esta função foi criada ao conectar o sinal da AreaVisao
func _on_area_visao_body_entered(body):
	machucar_player(body)

# Criei essa função auxiliar para não repetir código
func machucar_player(body):
	if body.name == "Player":
		print("Te peguei!")
		if body.has_method("receber_dano"):
			body.receber_dano()
func receber_ataque(dano):
	vida_inimigo -= dano
	print("Inimigo levou tomataço! Vida restante: ", vida_inimigo)
	
	# Efeito visual opcional: mudar de cor rapidinho pra vermelho
	modulate = Color(1, 0, 0) # Fica vermelho
	await get_tree().create_timer(0.1).timeout # Espera 0.1s
	modulate = Color(1, 1, 1) # Volta ao normal
	
	if vida_inimigo <= 0:
		morrer()

func morrer():
	print("Inimigo derrotado!")
	queue_free() # Remove o inimigo do jogo


func _on_tomate_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
