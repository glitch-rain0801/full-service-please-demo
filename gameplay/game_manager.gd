extends Node
class_name GameManager

class Shift extends RefCounted:
	const MORNING: String = "morning"
	const NOON: String = "noon"

class GameTime extends RefCounted:
	var week: int = 1
	var day: int = 1
	var hour: int = 0
	var shift: String = Shift.MORNING

@export var event_manager: EventManager
@export var spawn_manager: SpawnManager

var time: GameTime

func _ready() -> void:
	time = GameTime.new()
	start_week()

func start_week() -> void:
	var world_map: WorldMap = Global.main.get_current_world_scene()
	if world_map is not WorldMap:
		push_error("ERROR: Returned node is not of class 'WorldMap'.")
		return
	
	var service_area: ServiceArea = world_map.get_service_area()
	service_area.set_useable_rooms(time.week)
	
	for i in range(7):
		await start_shift()
		await end_shift()

func start_shift() -> void:
	if time.day == 7:
		return
	
	var morning_perk: Dictionary = await event_manager.get_workshift_perk(time)
	if morning_perk.get("name") != null:
		pass
	
	await get_tree().create_timer(5).timeout
	await spawn_manager.spawn_waves(4)

func end_shift() -> void:
	await get_tree().create_timer(5).timeout
	pass
