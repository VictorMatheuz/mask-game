extends CharacterBody2D


const SPEED = 300.0
var vel : float


func _physics_process(delta: float) -> void:
	
	move_local_x(vel * SPEED * delta)
