class_name Antojo
extends TextureRect

@export var cantidad: int = 0
@export var spawner: Spawner
var comestible: Comestible

var comido: bool = false

func _ready():
	var c = spawner.spawneable
	comestible = c.instantiate()
	texture = comestible.icon
	
	setComido(false)
	

func setComido(b: bool):
	comido = b
	
	if !comido:
		self_modulate = Color(1.0, 1.0, 1.0, 0.5)
	else:
		self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	
