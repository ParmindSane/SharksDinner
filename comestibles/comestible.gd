class_name Comestible
extends CharacterBody2D

@export var speed: Vector2
@export var speedMargen: Vector2

@onready var sprite := $AnimatedSprite2D

var areasMordibles: Array[AreaMordible]

func _ready():
	for a in get_tree().get_nodes_in_group("areaMordible"):
		a.enBocado.connect(enBoca)
		a.mordido.connect(mordido)
	
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
	
	#var cambiar = [_setX, _setY]
	#var actual = [sign(velocity.x), sign(velocity.y)]
	#var dir := [+1, +1]
	#for i in range(2):
		#if cambiar[i]:
			#dir[i] = [+1,-1].pick_random()
		#else:
			#dir[i] = actual[i]
	#
	#return Vector2((speed.x + speedMargen.x) * dir[0], (speed.y + speedMargen.y) * dir[1])
	

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
	pass
	
func mordido():
	print("mordido")
	morir()
	
func morir():
	queue_free()
	
