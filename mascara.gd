extends Area2D

var timeline_dialogo = "ato2_con"

func _on_body_entered(body):
	if body.name == "Player47":
		ativar_dialogo()
		
func ativar_dialogo():
		Dialogic.start(timeline_dialogo)

		queue_free()
