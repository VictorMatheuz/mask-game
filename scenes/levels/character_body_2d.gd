extends CharacterBody2D


# --- CONFIGURAÇÕES DE MOVIMENTO ---
@export var velocidade = 300.0
@export var forca_do_pulo = -600.0
var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
var cena_tomate = preload("res://scenes/levels/tomate.tscn")
var ultima_direcao = 1

# --- CONFIGURAÇÕES DE VIDA (NOVO) ---
var vida = 1 

# Esta função roda 60 vezes por segundo (é o coração do movimento)
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
	
	if Input.is_action_just_pressed("ataque"):
		atirar_tomate()

# --- NOVO: Função de Atirar ---
func atirar_tomate():
	# 1. Criar uma cópia (instância) do tomate
	var novo_tomate = cena_tomate.instantiate()
	
	# 2. Definir a posição inicial dele
	# Colocamos na mesma posição do player
	novo_tomate.position = position

# Ajuste lateral: Joga o tomate um pouco para frente do nariz
# Se ultima_direcao for 1 (direita), soma 20. Se for -1, subtrai 20.
	

# Ajuste vertical: Joga um pouco para cima (altura da mão/boca)

	get_parent().add_child(novo_tomate)

# --- FUNÇÃO DE RECEBER DANO (NOVO) ---
# O inimigo vai procurar por esta função quando encostar em você
func receber_dano():
	print("Ai! Levei dano!") # Isso aparece na aba Output abaixo
	vida -= 1
	
	if vida <= 0:
		morrer()

func morrer():
	print("Game Over")
	# Reinicia a fase
	get_tree().reload_current_scene()


func _on_area_visao_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
