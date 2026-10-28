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

var current_systems_scene: Node
var current_world_scene: Node2D
var current_entity_scene: Node2D
var current_effects_scene: Node2D
var current_menu_scene: Control
var current_hud_scene: Control
var current_pause_scene: Control
var current_transition_scene: Control
var current_debug_scene: Control

func _init() -> void:
	Global.main = self


func _ready() -> void:
	load_to_menu_node("res://ui/main_menu/main_menu.tscn")


func load_to_systems_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_systems_scene = new_scene
	systems_node.add_child(new_scene)


func load_to_world_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_world_scene = new_scene
	world_node.add_child(new_scene)


func load_to_entities_node(scene_path: String, params: Dictionary = {}) -> void:
	var new_scene = load(scene_path).instantiate()
	
	if params:
		if new_scene is Client:
			if (
				not params.has("client_data")
				or not params.has("preferred_masseur")
				or not params.has("queue_no")
			):
				push_error("ERROR: incomplete parameter declaration")
				return
			
			new_scene.client_data = params["client_data"]
			new_scene.preferred_masseur = params["preferred_masseur"]
			new_scene.queue_no = params["queue_no"]
		else: # ghost logic
			current_entity_scene = new_scene
	
	entities_node.add_child(new_scene)


func load_to_effects_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_effects_scene = new_scene
	effects_node.add_child(new_scene)


func load_to_menu_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_menu_scene = new_scene
	menu_node.add_child(new_scene)


func load_to_hud_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_hud_scene = new_scene
	hud_node.add_child(new_scene)


func load_to_pause_node(scene_path: String, params: Dictionary = {}) -> void:
	var new_scene = load(scene_path).instantiate()
	
	if params:
		if new_scene is PerkSelectionUI:
			if params.get("options") != null:
				new_scene.options = params["options"]
	
	current_pause_scene = new_scene
	
	pause_node.add_child(new_scene)


func load_to_transition_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_transition_scene = new_scene
	transition_node.add_child(new_scene)


func load_to_debug_node(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	current_debug_scene = new_scene
	debug_node.add_child(new_scene)

# Getter functions

func get_current_systems_scene() -> Node:
	return current_systems_scene


func get_current_world_scene() -> Node:
	return current_world_scene


func get_current_entity_scene() -> Node:
	return current_entity_scene

func get_entity_size(include_ghosts: bool = false) -> float:
	var count: float = 0.0
	for entity in entities_node.get_children():
		if not include_ghosts and entity is not Client:
			continue
		
		count += 1.0
	
	return count


func get_current_effects_scene() -> Node:
	return current_effects_scene


func get_current_menu_scene() -> Node:
	return current_menu_scene


func get_current_hud_scene() -> Node:
	return current_hud_scene


func get_current_pause_scene() -> Node:
	return current_pause_scene


func get_current_transition_scene() -> Node:
	return current_transition_scene


func get_current_debug_scene() -> Node:
	return current_debug_scene
