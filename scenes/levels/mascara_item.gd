extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Dialogic.start("res://timelines/ato2_con.dtl")
		queue_free()
	
