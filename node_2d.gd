extends Node2D

func _ready() -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start("ato1")
	set_physics_process(false)
	
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	get_tree().change_scene_to_file ("res://ato_2.tscn")
	
	
	
