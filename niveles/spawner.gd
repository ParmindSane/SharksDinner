class_name Spawner
extends CollisionShape2D

@export var spawneable: PackedScene
@export var maxCantidad: int = 1

@onready var random := RandomNumberGenerator.new()

signal comido(refe)

func _process(delta):
	if get_children().size() < maxCantidad:
		var s = spawneable.instantiate()
		add_child(s)
		
