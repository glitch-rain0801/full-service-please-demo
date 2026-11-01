extends Node2D
class_name TestMassageRoom

@export var masseur_sprite: Sprite2D
@export var client_display: Node2D
@export var client_sprite: Sprite2D

var current_masseur: MasseurData
var current_client: ClientData

func _ready() -> void:
	current_masseur = Entities.masseurs["kovit"]

func toggle_client_display(client: ClientData) -> void:
	current_client = client
	
	if not client:
		client_display.hide()
		return
	
	client_display.show()
	client_sprite.region_rect.position = current_client.atlas_coords * Entities.SPRITE_DIMENSIONS
	
	var test_overlay: TestOverlay = Global.main.get_current_debug_scene()
	test_overlay.service_started.emit(current_masseur, current_client)


func _on_masseur_updated(masseur_id: String) -> void:
	current_masseur = Entities.masseurs[masseur_id]
	
	masseur_sprite.region_rect.position = current_masseur.atlas_coords * Entities.SPRITE_DIMENSIONS


func _on_assignment_area_body_entered(body: Node2D) -> void:
	if body is Ghost:
		body.new_room = self


func _on_assignment_area_body_exited(body: Node2D) -> void:
	if body.is_queued_for_deletion():
		return
	
	body.new_room = null
