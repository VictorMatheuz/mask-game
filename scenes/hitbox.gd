extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player": # Certifique-se que o nó do seu personagem chama "Player"
		print("player chegou muito perto! Reiniciando...")
		
		# Chamamos a função de reiniciar de forma segura
		call_deferred("reiniciar_jogo")

func reiniciar_jogo():
	# Essa função recarrega a cena atual do zero (reset total)
	get_tree().reload_current_scene()
