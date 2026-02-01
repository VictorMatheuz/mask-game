extends CharacterBody2D

@onready var target=$"../../player"
var vida = 1

var speed=100
func _process(delta: float) -> void:
	var direction=(target.position-position).normalized()
	velocity=direction * speed
	look_at(target.position)
	move_and_slide()

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
	queue_free()
