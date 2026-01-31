extends CharacterBody3D


@export var timeline_npc: String = "timeline_do_npc_1"
var mascarado_esta_perto: bool = false

func _ready():
	var area = $AreaInteracao
	area.body_entered.connect(_ao_entrar_na_area)
	area.body_exited.connect(_ao_sair_da_area)

func _process(delta):
	if mascarado_esta_perto and Input.is_action_just_pressed("interagir"):
		if Dialogic.current_timeline == null:
			iniciar_conversa()
			
func _ao_entrar_na_area(body):
	if body.is_in_group("mascarado"):
		mascarado_esta_perto = true
		print("Pode falar agora!")
	
func _ao_sair_da_area(body):
	if body.is_in_group("mascarado"):
		mascarado_esta_perto = false
		print("Saiu de perto.")
		
func iniciar_conversa():
	Dialogic.start(timeline_npc)
