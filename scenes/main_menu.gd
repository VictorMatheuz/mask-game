extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_novo_jogo_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/ato_1.tscn")
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start("ato1")
	
	set_physics_process(false)
	

func ended():
	Dialogic.timeline_ended.disconnect(ended)
	set_physics_process(true)


func _on_sair_pressed() -> void:
	get_tree().quit()





func _on_como_jogar_pressed() -> void:
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start("res://como jogar.dtl")
