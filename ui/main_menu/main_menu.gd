extends PanelContainer
class_name MainMenu


func load_game() -> void:
	Global.main.load_to_world_node("res://locations/world_map.tscn")

func _on_new_game_pressed() -> void:
	load_game()
	queue_free()
