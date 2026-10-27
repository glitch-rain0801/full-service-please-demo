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


func _ready() -> void:
	pass


func load_to_systems_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	systems_node.add_child(new_scene)


func load_to_world_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	world_node.add_child(new_scene)


func load_to_entities_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	entities_node.add_child(new_scene)


func load_to_effects_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	effects_node.add_child(new_scene)


func load_to_menu_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	menu_node.add_child(new_scene)


func load_to_hud_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	hud_node.add_child(new_scene)


func load_to_pause_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	pause_node.add_child(new_scene)


func load_to_transition_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	transition_node.add_child(new_scene)


func load_to_debug_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	debug_node.add_child(new_scene)
