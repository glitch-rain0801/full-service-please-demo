extends CharacterBody2D
class_name Client

@export var sprite: Sprite2D

const SPRITE_COORDS: Vector2 = Vector2(256.0, 416.0)

var client_data: ClientData
var preferred_masseur: String
var queue_no: Vector2

var tween: Tween

func _ready() -> void:
	sprite.region_rect.position = client_data.atlas_coords * SPRITE_COORDS
	global_position = Vector2(1344.0, 400.0)
	
	tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		queue_no,
		5
	)
