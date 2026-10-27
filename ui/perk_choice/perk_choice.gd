extends PanelContainer
class_name PerkChoice

var perk_selection_ui: PerkSelectionUI

var tween: Tween
var hovered: bool = false

func play_intro() -> void:
	tween = create_tween()
	tween.tween_property(
		self,
		"offset_transform_position",
		Vector2.ZERO,
		0.5
	).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and hovered:
			perk_selection_ui.set_selected_perk(self)


func _on_select_area_mouse_entered() -> void:
	hovered = true


func _on_select_area_mouse_exited() -> void:
	hovered = false
