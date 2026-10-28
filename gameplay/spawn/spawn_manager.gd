extends Node
class_name SpawnManager

const QUEUE_START_COORDS: Vector2 = Vector2(4.2, 6)
const GRID_SIZE: Vector2 = Vector2(64.0, 64.0)

func spawn_random(number: int, include_regulars: bool = false, include_special: bool = false) -> void:
	for i in range(number):
		var client_pool: Array = _set_client_pool(include_special)
		var client_data: ClientData = _set_client(client_pool)
		var preferred_masseur: String
		if include_regulars:
			preferred_masseur = _set_affinity(client_data)
		
		var queue_no: Vector2 = _get_queue_pos() * GRID_SIZE
		
		Global.main.load_to_entities_node(
			"res://entities/clients/client.tscn",
			{
				"client_data": client_data,
				"preferred_masseur": preferred_masseur,
				"queue_no": queue_no
			}
		)


func spawn_scripted() -> void:
	pass


func spawn_ghost() -> void:
	pass


func spawn_waves(number: int) -> void:
	for i in range(number):
		spawn_random(1)
		await get_tree().create_timer(5).timeout


func _set_client_pool(include_special: bool) -> Array:
	var client_pool: Array = []
	
	for id in Entities.clients:
		if Entities.clients[id] == null:
			continue
		
		var client: ClientData = Entities.clients[id]
		if not include_special and client.is_special:
			continue
		
		client_pool.append(id)
	
	return client_pool


func _set_affinity(client: ClientData) -> String:
	var preferred_masseur: String = ""
	var total_affinity: float = client.neutral_affinity
	
	for id in client.affinity_tree:
		total_affinity += client.affinity_tree[id]
	
	var roll: float = randf_range(0, total_affinity)
	
	for id in client.affinity_tree:
		roll -= client.affinity_tree[id]
		
		# this avoids masseur assignment on a '0' roll and the affinity_tree values are '0'.
		if roll < 0:
			preferred_masseur = id
			break
	
	return preferred_masseur


func _set_client(client_pool: Array) -> ClientData:
	var total_weight: float = 0.0
	
	for id in client_pool:
		var client: ClientData = Entities.clients[id]
		
		total_weight += client.spawn_weight
	
	var roll: float = randf_range(0.0, total_weight)
	
	for id in client_pool:
		var client: ClientData = Entities.clients[id]
		
		roll -= client.spawn_weight
		
		if roll <= 0:
			return Entities.clients[id]
	
	return Entities.clients[client_pool.back()]


func _get_queue_pos() -> Vector2:
	var size: float = Global.main.get_entity_size()
	
	var new_xqueue_no: float = 0
	for i in range(size):
		new_xqueue_no += 1.2
	
	return QUEUE_START_COORDS + Vector2(new_xqueue_no, 0)
