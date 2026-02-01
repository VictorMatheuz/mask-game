extends CharacterBody2D


const SPEED = 600.0
var vel : float


func _physics_process(delta: float) -> void:
	
	move_local_x(vel * SPEED * delta)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Verificamos se o corpo em que batemos tem a função de receber dano
	if body.has_method("receber_dano"):
		body.receber_dano(1)
		queue_free() # O tomate some ao atingir o inimigo
