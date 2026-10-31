extends Node2D
class_name MassageRoom

@export var masseur_display: Node2D
@export var masseur_sprite: Sprite2D
@export var client_display: Node2D
@export var client_sprite: Sprite2D
@export var pickup_zone: CollisionShape2D
@export var assignment_zone: CollisionShape2D
@export var items: Control
@export var barrier: Control
@export var assign_masseur_ui: Control
@export var unavailable_ui: Control

var current_masseur: MasseurData
var current_client: ClientData
var spawn_manager: SpawnManager
var service_manager: ServiceManager

var hovering: bool = false
var button_held: bool = false

func _ready() -> void:
	await get_tree().process_frame
	var game_manager: GameManager = Global.main.get_current_systems_scene()
	if game_manager is not GameManager:
		push_error("Returned node is not of type 'GameManager'")
		return
	
	service_manager = game_manager.get_service_manager()
	spawn_manager = game_manager.get_spawn_manager()


func set_availability(state: bool) -> void:
	masseur_display.hide()
	client_display.hide()
	items.hide()
	pickup_zone.disabled = true
	barrier.show()
	
	if state:
		unavailable_ui.hide()
		assignment_zone.disabled = false
		assign_masseur_ui.show()
	else:
		unavailable_ui.show()
		assign_masseur_ui.hide()
		assignment_zone.disabled = true


func toggle_masseur_display(masseur: MasseurData) -> void:
	if not masseur:
		barrier.show()
		
		pickup_zone.disabled = true
		masseur_display.hide()
		
		if current_masseur:
			var masseur_reference: MasseurData = current_masseur
			current_masseur = null
			if service_manager.check_used_masseur(masseur_reference.id):
				return
			
			masseur_reference.active = false
		
		return
	
	masseur.active = true
	barrier.hide()
	
	pickup_zone.disabled = false
	masseur_display.show()
	
	masseur_sprite.region_rect.position = masseur.atlas_coords * Entities.SPRITE_DIMENSIONS
	current_masseur = masseur


func toggle_client_display(client: ClientData) -> void:
	if not client:
		pickup_zone.disabled = false
		assignment_zone.disabled = false
		
		client_display.hide()
		current_client = null
		return
	
	pickup_zone.disabled = true
	assignment_zone.disabled = true
	client_display.show()
	
	client_sprite.region_rect.position = client.atlas_coords * Entities.SPRITE_DIMENSIONS
	current_client = client


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and hovering:
			button_held = true
			spawn_manager.spawn_ghost(current_masseur.id, self)
		elif not event.pressed and button_held:
			button_held = false
			spawn_manager.free_ghost()

func _on_assign_pressed() -> void:
	var masseur: MasseurData = await service_manager.set_working_masseur()
	toggle_masseur_display(masseur)


func _on_pickup_area_mouse_entered() -> void:
	hovering = true


func _on_pickup_area_mouse_exited() -> void:
	hovering = false


func _on_assignment_area_body_entered(body: Node2D) -> void:
	if body is Ghost:
		body.new_room = self


func _on_assignment_area_body_exited(body: Node2D) -> void:
	if body is not Ghost:
		return
	
	if body.is_queued_for_deletion():
		return
	
	body.new_room = null
