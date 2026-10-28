extends PanelContainer
class_name PerkSelectionUI

signal perk_selected(perk: Control)

@export var perk_container: Control
@export var confirm_button: Control

var selected_perk: Control

var options: Array
var tween: Tween

const DEBUG_ARRAY: Array = ["items", "items", "items"]

func _ready() -> void:
	if options.is_empty():
		options = DEBUG_ARRAY
	
	for i in range(options.size()):
		var new_perk: PerkChoice = load("res://ui/perk_choice/perk_choice.tscn").instantiate()
		new_perk.perk_selection_ui = self
		perk_container.add_child(new_perk)
	
	self_modulate.a = 0.0
	confirm_button.disabled = true
	
	tween = create_tween()
	tween.tween_property(
		self,
		"self_modulate",
		Color("ffffffaa"),
		1
	)
	await tween.finished
	
	for perk: PerkChoice in perk_container.get_children():
		perk.play_intro()
		
		if perk == perk_container.get_children().back():
			tween = create_tween()
			tween.tween_property(
				confirm_button,
				"offset_transform_position",
				Vector2.ZERO,
				0.5
			).set_trans(Tween.TRANS_QUINT).set_ease(tween.EASE_OUT)
		
		await get_tree().create_timer(0.2).timeout


func set_selected_perk(perk: PerkChoice) -> void:
	confirm_button.disabled = false
	selected_perk = perk


func _on_confirm_pressed() -> void:
	perk_selected.emit(selected_perk)
	queue_free()
