extends Node2D
class_name Playground

@export var test_massage_room: TestMassageRoom
@export var test_client: TestClient

var test_overlay: TestOverlay

func _ready() -> void:
	await get_tree().process_frame
	test_overlay = Global.main.get_current_debug_scene()
	test_overlay.masseur_updated.connect(Callable(test_massage_room, "_on_masseur_updated"))
	test_overlay.client_updated.connect(Callable(test_client, "_on_client_updated"))
