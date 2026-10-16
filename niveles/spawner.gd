class_name Spawner
extends CollisionShape2D

@export var spawneable: PackedScene
@export var maxCantidad: int = 1

@onready var random := RandomNumberGenerator.new()

func _process(delta):
	if get_children().size() < maxCantidad:
		var s: Comestible = spawneable.instantiate()
		
		s.s_morir.connect(pezMuerto.bind(s))
		
		add_child(s)
	

signal s_pezMuerto(refe: Comestible)
func pezMuerto(refe: Comestible):
	s_pezMuerto.emit(refe)
	
