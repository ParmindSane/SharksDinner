@icon("res://comestibles/fish/assets/fish.png")
class_name Fish
extends Comestible

func _ready():
	super()
	
	velocity *= getNewVel()
	

func _physics_process(_delta):
	var col := move_and_collide(velocity * _delta)
	
	if col:
		choque(col)
	

func getNewVel() -> Vector2:
	var mX = randf_range(-speedMargen.x, +speedMargen.x)
	var mY = randf_range(-speedMargen.y, +speedMargen.y)
	return speed + Vector2(mX, mY)
	

signal s_choque(refe: Comestible)
func choque(_c: KinematicCollision2D):
	s_choque.emit(self)
	
	rebotar(_c)
	

signal s_rebotar(refe: Comestible)
func rebotar(_c: KinematicCollision2D):
	s_rebotar.emit(self)
	
	var n = _c.get_normal()
	var dir = sign(velocity.bounce(n))
	var pDir = sign(velocity)
	
	velocity = dir * getNewVel()
	
	if dir.x != pDir.x:
		scale.x *= -1
	
