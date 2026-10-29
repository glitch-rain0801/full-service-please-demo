extends Resource
class_name MasseurData

@export var id: String
@export var name: String
@export var tag: String
@export_multiline var description: String
@export var speciality: String
@export var atlas_coords: Vector2

@export var active: bool = false
@export var busy: bool = false
@export var downed: bool = false
@export var unlocked: bool = true
