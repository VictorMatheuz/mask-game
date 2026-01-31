extends Area3D


@export var timeline_dialogo: String = "timeline_da_mascara"

func _ready():
	body_entered.connect(_ao_entrar_no_item)
func _ao_entrar_no_item(body):
	if body.is_in_group("mascarado"):
		print("O mascarado tocou no item!")
		if timeline_dialogo != "":
			Dialogic.start(timeline_dialogo)
			coletar_item()
func coletar_item():
	queue_free()
