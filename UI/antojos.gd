class_name Antojos
extends Container

@export var antojos: Array[Antojo]

@onready var antojoRef: TextureRect = $HBoxContainer/Antojo
var antojosNodes: Array

func _ready():
	for a in antojos:
		var s: Spawner = get_node(a.spawner)
		var si: Comestible = s.spawneable.instantiate()
		var icon = si.icon
		antojosNodes.push_back([TextureRect])
		
		for i in range(a.cantidad):
			var a2: TextureRect = antojoRef.duplicate()
			
			a2.texture = icon
			
			antojoRef.add_sibling(a2)
			antojosNodes[antojos.find(a)].push_back(a2)
	
	antojoRef.hide()
	

func setComido(b: bool):
	for a in antojosNodes:
		if a.self_modulate != Color(1.0, 1.0, 1.0, 1.0):
			if !b:
				self_modulate = Color(1.0, 1.0, 1.0, 0.5)
			else:
				self_modulate = Color(1.0, 1.0, 1.0, 1.0)
			return
	
