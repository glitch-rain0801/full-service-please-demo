extends Node2D
class_name TestClient

@export var client_display: Node2D
@export var client_sprite: Sprite2D
@export var pickup_zone: CollisionShape2D

var test_manager: TestManager

var hovering: bool = false
var button_held: bool = false

var client: ClientData

func _ready() -> void:
	await get_tree().process_frame
	test_manager = Global.main.get_current_systems_scene()
	client = Entities.clients["bara_white"]
 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and hovering:
			button_held = true
			test_manager.spawn_ghost(client.id)
		elif not event.pressed and button_held:
			button_held = false
			test_manager.free_ghost()
			var check: bool = await test_manager.room_found
			
			if check:
				client_display.hide()
				pickup_zone.disabled = true
				var test_overlay: TestOverlay = Global.main.get_current_debug_scene()
				test_overlay.disable_client_options(true)
				test_overlay.disable_masseur_select(true)


func _on_client_updated(client_id: String) -> void:
	if not client_display.visible:
		client_display.show()
		pickup_zone.disabled = false
	
	var new_id = client_id
	if client_id in ['black', 'white']:
		new_id = "bara_" + client_id
	else:
		new_id = "tomoki"
	
	client = Entities.clients[new_id]
	client_sprite.region_rect.position = client.atlas_coords * Entities.SPRITE_DIMENSIONS


func _on_pickup_area_mouse_entered() -> void:
	hovering = true


func _on_pickup_area_mouse_exited() -> void:
	hovering = false
