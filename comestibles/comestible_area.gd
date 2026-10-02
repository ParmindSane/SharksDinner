class_name AreaMordible
extends Area2D

var padre: Node
func _ready():
	padre = get_tree().get_first_node_in_group("padre")
	add_to_group("areaMordible")
	

func getPadre():
	return padre
	

signal enBocado
func enBocar():
	enBocado.emit()
	

signal mordido
func morder():
	mordido.emit()
