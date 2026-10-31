extends PanelContainer
class_name ClientFlags

@export var toggle_button: Button

const HIDE_COORDS: Vector2 = Vector2(0.0, 272.0)

var toggled: bool = false

var tween: Tween

func _on_toggle_pressed() -> void:
	if toggled:
		toggled = false
		
		tween = create_tween()
		tween.tween_property(
			self,
			"offset_transform_position",
			HIDE_COORDS,
			0.5
		)
		
		toggle_button.text = "Show"
	else:
		toggled = true
		
		tween = create_tween()
		tween.tween_property(
			self,
			"offset_transform_position",
			Vector2.ZERO,
			0.5
		)
		
		toggle_button.text = "Hide"
