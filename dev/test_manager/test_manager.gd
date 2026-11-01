extends Node2D
class_name TestManager

signal ghost_freed(client: ClientData, new_room: TestMassageRoom)
signal room_found(state: bool)


func _ready() -> void:
	ghost_freed.connect(Callable(self, "_on_ghost_freed"))


func spawn_ghost(client_id: String) -> void:
	var entity: Variant = Entities.clients[client_id]
	
	Global.main.load_to_entities_node(
		"res://entities/ghost/ghost.tscn",
		{ 
			"entity": entity,
			"requesting_node": null
		}
	)

func free_ghost() -> void:
	var ghost: Ghost = Global.main.get_current_entity_scene()
	ghost.queue_free()


func start_service() -> void:
	pass


func _on_ghost_freed(client: ClientData, new_room: TestMassageRoom) -> void:
	if new_room:
		new_room.toggle_client_display(client)
		room_found.emit(true)
		return
	
	room_found.emit(false)
