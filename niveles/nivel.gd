class_name Nivel
extends Node2D

@export var antojosContainer: PanelContainer
var antojos: Array[Antojo]

#func _ready():
	#for f in get_tree().get_nodes_in_group("comestible"):
		#print(f)
	#
