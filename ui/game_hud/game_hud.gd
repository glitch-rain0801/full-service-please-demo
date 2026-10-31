extends PanelContainer
class_name GameHUD

@export var coin_label: Label
@export var order_container: Control

var economy_manager: EconomyManager

func _ready() -> void:
	await get_tree().process_frame
	var game_manager: GameManager = Global.main.get_current_systems_scene()
	if game_manager is not GameManager:
		push_error("Returned node is not of type 'GameManager'")
		return
	
	economy_manager = game_manager.get_economy_manager()
	economy_manager.coins_updated.connect(Callable(self, "_on_coins_updated"))


func load_to_orders(client: Client) -> void:
	var new_order: ClientOrderCard = load("res://ui/client_order_card/client_order_card.tscn").instantiate()
	new_order.client = client.client_data
	order_container.add_child(new_order)


func _on_coins_updated(amount: float) -> void:
	coin_label.text = str(amount)
