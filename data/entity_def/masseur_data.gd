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

var current_energy: float

@export var base_service_time: float = 10.0
@export var base_service_cost: float = 1000.0
@export var base_max_energy: float = 100.0
@export var base_energy_cost: float = 50.0
@export var base_energy_gain: float = 25.0
@export var base_energy_refill_time: float = 30.0
@export var base_affinity_yield: float = 1.0
@export var base_affinity_bonus: float = 1.2
@export var base_speciality_bonus: float = 1.2
@export var base_relief_chance: float = 0.0
@export var base_relief_bonus: float = 1.5
@export var base_relief_time: float = 30.0
@export var base_relief_cost: float = 25.0

var mod_service_time: float
var mod_service_cost: float
var mod_max_energy: float
var mod_energy_cost: float
var mod_energy_refill_time: float
var mod_affinity_yield: float
var mod_affinity_bonus: float
var mod_speciality_bonus: float
var mod_relief_chance: float
var mod_relief_bonus: float
var mod_relief_time: float
var mod_relief_cost: float
