extends CharacterBody2D
class_name Ghost

@export var sprite: Sprite2D

var entity: Variant
var requesting_node: Variant
var new_room: MassageRoom

func _ready() -> void:
	sprite.region_rect.position = entity.atlas_coords * Entities.SPRITE_DIMENSIONS


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()


func _on_tree_exiting() -> void:
	var game_manager: GameManager = Global.main.get_current_systems_scene()
	if game_manager is not GameManager:
		push_error("Returned node is not of class 'GameManager'")
		return
	
	var spawn_manager: SpawnManager = game_manager.get_spawn_manager()
	spawn_manager.ghost_freed.emit(entity, requesting_node, new_room)
