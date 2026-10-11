class_name Comestible
extends CharacterBody2D

@export var speed: Vector2
@export var speedMargen: Vector2
@export var speedVenenoso: Vector2

@export var veneno := 0

@onready var sprite := $AnimatedSprite2D
@export var icon: Texture2D

var areasMordibles: Array[AreaMordible]

func _ready():
	for a in get_children():
		if a.is_in_group("areaMordible"):
			a.enBocado.connect(enBoca)
			a.mordido.connect(mordido)
	
	if veneno > 0:
		speed = speedVenenoso
	
	var dir = [-1, +1]
	var dX = dir.pick_random()
	var dY = dir.pick_random()
	velocity = getNewVel() * Vector2(dX, dY)
	
	if dX < 0:
		scale.x *= -1
	

func _physics_process(_delta):
	var col := move_and_collide(velocity * _delta)
	
	if col:
		choque(col)
	

func getNewVel():
	var mX = randf_range(-speedMargen.x, +speedMargen.x)
	var mY = randf_range(-speedMargen.y, +speedMargen.y)
	return Vector2(speed + Vector2(mX, mY))
	

func choque(_c: KinematicCollision2D):
	rebotar(_c)
	
func rebotar(_c: KinematicCollision2D):
	var n = _c.get_normal()
	var dir = sign(velocity.bounce(n))
	var pDir = sign(velocity)
	
	velocity = dir * getNewVel()
	
	if dir.x != pDir.x:
		scale.x *= -1
	

func enBoca():
	if veneno > 0:
		getPlayer().enfermar()
		morir()
	
func mordido():
	morir()
	
func morir():
	queue_free()
	

func getPlayer() -> Shark:
	return get_tree().get_first_node_in_group("Shark")
	
