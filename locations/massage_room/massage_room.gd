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
