class_name Comestible
extends CharacterBody2D

@export var speed: Vector2
@export var speedMargen: Vector2

func _ready():
	var dir = [-1, +1]
	var dX = dir.pick_random()
	var dY = dir.pick_random()
	velocity = getNewVel() * Vector2(dX, dY)
	

func _process(_delta):
	$Label.text = str(velocity)
	

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
	velocity = sign(velocity.bounce(n)) * getNewVel()
	#move_and_collide(_c.get_remainder().bounce(n))
	

func mordido():
	morir()
	
func morir():
	queue_free()
	
