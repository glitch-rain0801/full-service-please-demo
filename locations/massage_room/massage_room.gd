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


func _on_assign_pressed() -> void:
	var game_manager: GameManager = Global.main.get_current_systems_scene()
	if game_manager is not GameManager:
		push_error("returned node is not of type 'GameManager'")
		return
	
	var service_manager: ServiceManager = game_manager.get_service_manager()
	var masseur: MasseurData = await service_manager.set_working_masseur()
	
	print(masseur)
