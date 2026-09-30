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
	velocity = Vector2(velocity.x, 0)
	move_and_slide()
	
	if is_on_wall():
		var col = get_last_slide_collision()
		var normal = col.get_normal()
		var ang = normal.angle_to(Vector2.UP)
		if abs(ang) > PI*0.3 && abs(ang) < PI-PI*0.3:
			dir.x = -dir.x
			velocity = Vector2(speed.x/2 * dir.x, 0)
			
			var resto = Vector2(-col.get_remainder().x/2, 0)
			move_and_collide(resto)
			
			rebotando = true
			await get_tree().create_timer(0.5).timeout
			rebotando = false
	
	if !rebotando:
		dir.y = Input.get_axis("ui_up", "ui_down")
		velocity = Vector2(speed.x * dir.x, speed.y * dir.y)
		
		sprite.flip_h = dir.x < 0
		boca.get_child(0).position.x = bocaPos * dir.x
		
		move_and_collide(Vector2(0, velocity.y * delta))
	
	if estado == estados.enfermo:
		sprite.play("enfermo")
	else:
		if Input.is_action_pressed("ui_accept") && !rebotando:
			estado = estados.bocaAbierta
			sprite.play("morder")
		else:
			estado = estados.bocaCerrada
			sprite.play("default")
			
			boca.process_mode = Node.PROCESS_MODE_DISABLED
			if pEstado == estados.bocaAbierta && !rebotando:
				boca.process_mode = Node.PROCESS_MODE_INHERIT
	pEstado = estado
	

func morder(area: Area2D):
	print("Mordiendo: " + str(area))
	
