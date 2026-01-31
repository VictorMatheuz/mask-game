extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Dialogic.start("timeline_da_mascara")
		queue_free()
	
