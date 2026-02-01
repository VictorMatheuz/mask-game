extends CharacterBody2D

# Definimos a vida inicial
var vida = 20
@export var cor_dano = Color(1, 0, 0) # Cor vermelha para o piscar de dano

func _ready():
	# Adicionamos o inimigo a um grupo para fácil identificação
	add_to_group("inimigos")

# Esta função será chamada pelo tomate ou pela detecção de área
func receber_dano(quantidade):
	vida -= quantidade
	print("Vida do Inimigo: ", vida)
	
	# Feedback visual simples: pisca em vermelho
	modulate = Color(1, 0, 0) # Fica vermelho
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1, 1, 1) # Volta ao normal
	
	if vida <= 0:
		morrer()

func morrer():
	# Aqui você pode tocar uma animação de morte antes de deletar
	print("O Boss foi derrotado!")
	queue_free()
	
func _on_zona_morte_body_entered(body: Node2D) -> void:
	# Verificamos se quem entrou na área foi o Player
	if body.name == "player": # Certifique-se que o nó do seu personagem chama "Player"
		print("player chegou muito perto! Reiniciando...")
		
		# Chamamos a função de reiniciar de forma segura
		call_deferred("reiniciar_jogo")

func reiniciar_jogo():
	# Essa função recarrega a cena atual do zero (reset total)
	get_tree().reload_current_scene()
