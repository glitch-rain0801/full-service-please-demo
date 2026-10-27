extends PanelContainer
class_name MainMenu


func load_game() -> void:
	Global.main.load_to_world_node("res://locations/world_map.tscn")
	Global.main.load_to_systems_node("res://gameplay/game_manager.tscn")
	Global.main.load_to_hud_node("res://ui/game_hud/game_hud.tscn")

func _on_new_game_pressed() -> void:
	load_game()
	queue_free()
