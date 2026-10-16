class_name Comestible
extends CharacterBody2D

@export var speed: Vector2
@export var speedMargen: Vector2
var dirInicial: Vector2

@export var damage := 0

@onready var sprite := $AnimatedSprite2D
@export var icon: Texture2D

var areasMordibles: Array[AreaMordible]

func _ready():
	for a in get_children():
		if a.is_in_group("areaMordible"):
			a.enBocado.connect(enBoca)
			a.mordido.connect(mordido)
	
	dirInicial = getRandomDir()
	velocity = dirInicial
	if dirInicial.x < 0:
		scale.x *= -1
	

signal s_enBoca(refe: Comestible)
func enBoca():
	s_enBoca.emit(self)
	
	if damage > 0:
		getPlayer().vomitar()
		morir()
	

signal s_mordido(refe: Comestible)
func mordido():
	s_mordido.emit(self)
	
	morir()
	

signal s_morir(refe: Comestible)
func morir():
	s_morir.emit(self)
	
	queue_free()
	

func getPlayer() -> Shark:
	return get_tree().get_first_node_in_group("Shark")
	

func getRandomDir() -> Vector2:
	var dir = [-1, +1]
	return Vector2(dir.pick_random(), dir.pick_random())
	
