extends Resource
class_name ClientData

@export var id: String
@export var name: String
@export var atlas_coords: Vector2

@export var is_special: bool = false
@export var spawn_weight: float = 10.0
@export var neutral_affinity: float = 10.0
@export var affinity_tree: Dictionary[String, float] = {
	"kovit": 0.0,
	"rald": 0.0,
	"remi": 0.0,
	"sota": 0.0,
	"lenga": 0.0,
	"okan": 0.0,
	"oki": 0.0
}
