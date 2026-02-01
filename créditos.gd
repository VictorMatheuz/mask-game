extends Control


var cena_menu = "res://scenes/main_menu.tscn"

func _ready():
	# Conecta o sinal de "acabou a animação"
	# Assim que o AnimationPlayer terminar, ele chama a função _on_animation_finished
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)

func _process(delta):
	# Permite pular os créditos apertando qualquer tecla de ação ou ESC
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		voltar_pro_menu()

func _on_animation_finished(nome_da_animacao):
	voltar_pro_menu()

func voltar_pro_menu():
	get_tree().change_scene_to_file(cena_menu)
