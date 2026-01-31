extends Area2D

func _on_body_entered(body):
	# 1. Verifica se quem entrou na área é o Player
	if body.name == "Player":
		
		# 2. Verifica se o Player tem a função "receber_dano"
		# Isso evita erros se o inimigo encostar em algo que não sangra (como uma parede)
		if body.has_method("receber_dano"):
			
			# 3. Manda o player se machucar
			body.receber_dano()
