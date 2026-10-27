extends Node
class_name Main

@export var systems_node: Node
@export var world_node: Node2D
@export var entities_node: Node2D
@export var effects_node: Node2D
@export var menu_node: Control
@export var hud_node: Control
@export var pause_node: Control
@export var transition_node: Control
@export var debug_node: Control


func _init() -> void:
	Global.main = self
