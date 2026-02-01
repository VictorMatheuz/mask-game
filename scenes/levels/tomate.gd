extends Area2D

var velocidade = 400
var direcao = 1 
var dano = 1

func _physics_process(delta):
	position.x += velocidade * direcao * delta

func _on_body_entered(body):
	if body.name == "Player":
		return 
	
	if body.has_method("receber_dano"):
		body.receber_dano(1)
		queue_free() 
	else:
		queue_free()
