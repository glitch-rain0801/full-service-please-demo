extends Node2D
class_name WorldMap

@export var lounge_area: Node2D
@export var service_area: ServiceArea
@export var camera: Camera2D

var map_coords: Dictionary = {
	"lounge_area": Vector2(0.0, 0.0),
	"service_area": Vector2(-1344.0, 0.0)
}
var disable_input: bool = false

var tween: Tween

func get_lounge_area() -> Node2D:
	return lounge_area


func get_service_area() -> ServiceArea:
	return service_area


func get_map_coords_key() -> String:
	var camera_coords: Vector2 = get_camera_pos()
	
	for area in map_coords:
		if map_coords[area] == camera_coords:
			return area
	
	return ""


func get_camera_pos() -> Vector2:
	return camera.global_position


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		if get_map_coords_key() == "service_area":
			return
		
		_move_camera("service_area")
	elif event.is_action_pressed("right"):
		if get_map_coords_key() == "lounge_area":
			return
		_move_camera("lounge_area")


func _move_camera(area: String) -> void:
	if disable_input:
		return
	
	disable_input = true
	
	tween = create_tween()
	tween.tween_property(
		camera,
		"global_position",
		map_coords[area],
		0.5
	)
	await tween.finished
	
	disable_input = false
