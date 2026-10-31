extends Node
class_name SpawnManager

signal queue_updated
signal ghost_freed(entity: Variant, requesting_node: Variant, new_room: MassageRoom)

const QUEUE_START_COORDS: Vector2 = Vector2(4.2, 6)
const GRID_SIZE: Vector2 = Vector2(64.0, 64.0)

func _ready() -> void:
	ghost_freed.connect(Callable(self, "_on_ghost_freed"))


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


func spawn_ghost(entity_id: String, node: Variant) -> void:
	var entity: Variant = Entities.masseurs[entity_id] \
	if entity_id in Entities.masseurs else Entities.clients[entity_id]
	
	Global.main.load_to_entities_node(
		"res://entities/ghost/ghost.tscn",
		{ 
			"entity": entity,
			"requesting_node": node
		}
	)


func spawn_waves(number: int) -> void:
	for i in range(number):
		spawn_random(1)
		await get_tree().create_timer(5).timeout


func free_ghost() -> void:
	var ghost: Ghost = Global.main.get_current_entity_scene()
	if ghost is not Ghost:
		push_error("Returned node is not of class 'Ghost'")
		return
	
	ghost.queue_free()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var world_map: WorldMap = Global.main.get_current_world_scene()
		if world_map is not WorldMap:
			push_error("Returned node is not of class 'WorldMap'.")
			return
		
		if world_map.get_map_coords_key() != "lounge_area":
			return
		
		var entities: Array = Global.main.get_entities()
		if entities.is_empty():
			return
		
		var entity: Client = entities.front()
		
		if entity.queue_no.is_equal_approx(QUEUE_START_COORDS * GRID_SIZE):
			if entity.moving:
				return
			var game_hud = Global.main.get_current_hud_scene()
			if game_hud is not GameHUD:
				push_error("Returned node is not of type 'GameHUD'")
				return
			
			game_hud.load_to_orders(entity)
			entity.queue_free()
		
		queue_updated.emit()


func _on_ghost_freed(entity: Variant, requesting_node: Variant, new_room: MassageRoom) -> void:
	var new_masseur: MasseurData = null
	
	if new_room:
		new_masseur = new_room.current_masseur
		
		if entity is MasseurData and new_room != requesting_node:
			new_room.toggle_masseur_display(entity)
		
		if entity is ClientData:
			new_room.toggle_client_display(entity)
	
	if requesting_node is MassageRoom:
		if new_room == requesting_node:
			return
		
		requesting_node.toggle_masseur_display(new_masseur)
	elif requesting_node is ClientOrderCard:
		if new_room:
			requesting_node.queue_free()

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
