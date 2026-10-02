class_name Shark
extends CharacterBody2D

@export var speed: Vector2
var dir := Vector2(1,0)
var rebotando := false

@onready var sprite := $AnimatedSprite2D

@onready var boca := $boca
@onready var bocaPos = abs(boca.get_child(0).position.x)

enum estados {
	bocaCerrada,
	bocaAbierta,
	enfermo,
}
var estado = estados.bocaCerrada
@onready var pEstado = estado

func _ready():
	boca.area_entered.connect(morder)
	

func _process(delta):
	$Label.text = str(velocity)
	

func _physics_process(delta):
#	Movimiento horizontal
	velocity = Vector2(velocity.x, 0)
	move_and_slide()
	
#	Si hubo colisión...
	if is_on_wall():
		var col = get_last_slide_collision()
		var normal = col.get_normal()
		var ang = normal.angle_to(Vector2.UP)
		
#		...y la colisión fue contra algo lo bastante empinado...
		if abs(ang) > PI*0.3 && abs(ang) < PI-PI*0.3:
#			Ir para el otro lado
			dir.x = -dir.x
			velocity = Vector2(speed.x/2 * dir.x, 0)
			
#			Rebote
			var resto = Vector2(-col.get_remainder().x/2, 0)
			move_and_collide(resto)
			
#			Momento atontado
			rebotando = true
			await get_tree().create_timer(0.5).timeout
			rebotando = false
	
#	Cuando deja de rebotar...
	if !rebotando:
#		Movimiento vertical controlado por input
		dir.y = Input.get_axis("ui_up", "ui_down")
		velocity = Vector2(speed.x * dir.x, speed.y * dir.y)
		move_and_collide(Vector2(0, velocity.y * delta))
		
#		Voltear
		sprite.flip_h = dir.x < 0
		boca.get_child(0).position.x = bocaPos * dir.x
	
#	Estar enfermo
	if estado == estados.enfermo:
		sprite.play("enfermo")
		
#	NO estar enfermo
	else:
#		Abrir la boca
		if Input.is_action_pressed("ui_accept") && !rebotando:
			estado = estados.bocaAbierta
			boca.process_mode = Node.PROCESS_MODE_INHERIT
			sprite.play("bocaAbierta")
			
#		Cerrar la boca
		else:
			estado = estados.bocaCerrada
			boca.process_mode = Node.PROCESS_MODE_DISABLED
			sprite.play("default")
			
#			Si acaba de cerrar la boca, come lo que haya cerca
			if pEstado == estados.bocaAbierta && !rebotando:
				pass
				
	pEstado = estado
	

func morder(area: Area2D):
	print("Mordiendo: " + str(area))
	
