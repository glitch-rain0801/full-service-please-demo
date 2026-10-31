extends PanelContainer
class_name TestMainMenu

func _on_start_pressed() -> void:
	Global.main.load_to_world_node("res://dev/playground/playground.tscn")
	Global.main.load_to_debug_node("res://debug/overlay/test_overlay.tscn")
	queue_free()
