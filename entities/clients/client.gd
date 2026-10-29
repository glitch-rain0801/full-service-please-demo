extends CharacterBody2D
class_name Client

@export var sprite: Sprite2D

const SPRITE_COORDS: Vector2 = Vector2(256.0, 416.0)
const SPAWN_POINT: Vector2 = Vector2(1344.0, 384.0)

var moving: bool = false

var client_data: ClientData
var preferred_masseur: String
var queue_no: Vector2

var tween: Tween

func _ready() -> void:
	var game_manager: GameManager = Global.main.get_current_systems_scene()
	if game_manager is not GameManager:
		push_error("returned node is not of type 'GameManager'")
		return
			
	var spawn_manager: SpawnManager = game_manager.get_spawn_manager()
	spawn_manager.queue_updated.connect(Callable(self, "_on_queue_updated"))
	
	sprite.region_rect.position = client_data.atlas_coords * SPRITE_COORDS
	global_position = SPAWN_POINT
	moving = true
	
	tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		queue_no,
		_calculate_speed()
	)
	await tween.finished
	
	moving = false


func _calculate_speed() -> float:
	var speed: float = (global_position.x - queue_no.x)/200
	return speed


func _on_queue_updated() -> void:
	if tween:
		tween.kill()
	
	var new_xqueue_pos: float = (queue_no.x / 64) - 1.2
	queue_no.x = new_xqueue_pos * 64
	moving = true
	
	tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		queue_no,
		_calculate_speed()
	)
	await tween.finished
	
	moving = false
