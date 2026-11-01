extends Control
class_name TestOverlay

signal masseur_updated(masseur_id: String)
signal client_updated(client_id: String)
signal service_started(masseur: MasseurData, client: ClientData)
signal service_finished

@export var masseur_info: MasseurInfo
@export var option_button: OptionButton
@export var room_metrics: Control


func _ready() -> void:
	masseur_info.update_masseur_statistics(Entities.masseurs["kovit"])
	masseur_updated.connect(Callable(self, "_on_masseur_updated"))
	service_started.connect(Callable(self, "_on_service_started"))


func disable_client_options(state: bool) -> void:
	option_button.disabled = state


func disable_masseur_select(state: bool) -> void:
	for button in $MasseurSelect.button_array:
		button.disabled = state


func _on_masseur_updated(masseur_id: String) -> void:
	masseur_info.update_masseur_statistics(Entities.masseurs[masseur_id])


func _on_option_button_item_selected(index: int) -> void:
	client_updated.emit(option_button.get_item_text(index).to_lower())


func _on_service_started(masseur: MasseurData, client: ClientData) -> void:
	$RoomMetrics.update_room_metrics(
		"Active",
		str(masseur.base_service_time) + "s",
		"Servicing..."
	)
	
	await service_finished
	
	$RoomMetrics.update_room_metrics(
		"Active",
		str(masseur.base_relief_time) + "s",
		"Fucking..."
	)
	
	await service_finished
	
	disable_masseur_select(false)
	disable_client_options(false)
	client_updated.emit(client.id)
	var playground: Playground = Global.main.get_current_world_scene()
	playground.test_massage_room.toggle_client_display(null)
