extends CharacterBody2D
class_name Ghost

@export var sprite: Sprite2D

var entity: Variant
var requesting_node: Variant
var new_room: Variant

func _ready() -> void:
	sprite.region_rect.position = entity.atlas_coords * Entities.SPRITE_DIMENSIONS


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()


func _on_tree_exiting() -> void:
	var game_manager: Node = Global.main.get_current_systems_scene()
	if game_manager is GameManager:
		var spawn_manager: SpawnManager = game_manager.get_spawn_manager()
		spawn_manager.ghost_freed.emit(entity, requesting_node, new_room)
	elif game_manager is TestManager:
		game_manager.ghost_freed.emit(entity, new_room)
