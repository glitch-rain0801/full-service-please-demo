extends PanelContainer
class_name ClientOrderCard

const BASE_COORDS: Vector2 = Vector2(224.0, 0.0)
const HOVER_COORDS: Vector2 = Vector2(124.0, 0.0)

var client: ClientData

var hovering: bool = false
var button_held: bool = false

var spawn_manager: SpawnManager

var tween: Tween

func _ready() -> void:
	var game_manager: GameManager = Global.main.get_current_systems_scene()
	if game_manager is not GameManager:
		push_error("Returned node is not of type 'GameManager'")
		return
	spawn_manager = game_manager.get_spawn_manager()
	
	tween = create_tween()
	tween.tween_property(
		self,
		"offset_transform_position",
		BASE_COORDS,
		0.5
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and hovering:
			button_held = true
			spawn_manager.spawn_ghost(client.id, self)
		elif not event.pressed and button_held:
			button_held = false
			spawn_manager.free_ghost()


func _on_pickup_area_mouse_entered() -> void:
	hovering = true
	
	tween = create_tween()
	tween.tween_property(
		self,
		"offset_transform_position",
		HOVER_COORDS,
		0.3
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _on_pickup_area_mouse_exited() -> void:
	hovering = false
	
	tween = create_tween()
	tween.tween_property(
		self,
		"offset_transform_position",
		BASE_COORDS,
		0.3
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
