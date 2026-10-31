extends PanelContainer
class_name GameHUD

@export var order_container: Control

func load_to_orders(client: Client) -> void:
	var new_order: ClientOrderCard = load("res://ui/client_order_card/client_order_card.tscn").instantiate()
	new_order.client = client.client_data
	order_container.add_child(new_order)
