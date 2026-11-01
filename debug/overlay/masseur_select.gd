extends PanelContainer
class_name MasseurSelect

@export var button_array: Array[Button]

func _ready() -> void:
	for button in button_array:
		button.pressed.connect(Callable(self, "_on_button_pressed").bind(button.text))


func _on_button_pressed(button_text: String) -> void:
	var test_overlay: TestOverlay = Global.main.get_current_debug_scene()
	test_overlay.masseur_updated.emit(button_text.to_lower())
