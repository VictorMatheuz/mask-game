extends Area2D

var timeline_dialogo = "ato2_con"

func _on_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to_file("res://final.tscn")
		
