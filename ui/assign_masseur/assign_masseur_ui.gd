extends PanelContainer
class_name AssignMasseurUI

signal masseur_selected(masseur_name: String)

@export var masseur_buttons: Control
@export var name_label: Label
@export var tag_label: Label
@export var desc_label: RichTextLabel
@export var select_button: Button
@export var image: TextureRect
@export var stats_page: Control 

const IMG_START_POS: Vector2 = Vector2(-160, 352)
const IMG_DEFAULT_POS: Vector2 = Vector2(-96.0, 352.0)
const STAT_START_POS: Vector2 = Vector2(128, 0)
const BTN_START_POS: Vector2 = Vector2(-24, 0)

var selected_masseur: String = "Kovit"
var tween: Tween

func _ready() -> void:
	var buttons: Array = masseur_buttons.get_children()
	self_modulate.a = 0.0
	
	for button: Button in buttons:
		button.pressed.connect(
			_on_button_pressed.bind(button.name)
		)
	
		if button != buttons.front():
			button.offset_transform_position = BTN_START_POS
	
	if not buttons.is_empty():
		var first_button: Button = buttons.front()
		first_button.button_pressed = true
		_play_intro_trans()


func _on_button_pressed(button_name: String) -> void:
	if button_name == selected_masseur:
		return
	
	_update_ui(button_name.to_lower())
	
	selected_masseur = button_name


func _play_intro_trans() -> void:
	var masseur: MasseurData = Entities.masseurs["kovit"]
	
	name_label.text = masseur.name
	tag_label.text = masseur.tag
	desc_label.text = masseur.description
	
	if masseur.active:
		select_button.disabled = true
		select_button.text = "Active"
	
	
	image.offset_transform_position = IMG_START_POS
	stats_page.offset_transform_position = STAT_START_POS
	
	if tween:
		tween.kill()
	
	tween = create_tween().set_parallel()
	
	tween.tween_property(
		self,
		"self_modulate",
		Color("#ffffffaa"),
		0.7
	).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(
		image,
		"offset_transform_position",
		IMG_DEFAULT_POS,
		0.7
	).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(
		stats_page,
		"offset_transform_position",
		Vector2.ZERO,
		0.7
	).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	for button: Button in masseur_buttons.get_children():
		var target_pos: Vector2 = (
			Vector2.ZERO
			if button.button_pressed
			else BTN_START_POS
		)
		
		tween.tween_property(
			button,
			"offset_transform_position",
			target_pos,
			0.2
		).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _update_ui(masseur_name: String) -> void:
	var masseur: MasseurData = Entities.masseurs[masseur_name]
	
	name_label.text = masseur.name
	tag_label.text = masseur.tag
	desc_label.text = masseur.description
	
	if not masseur.unlocked or masseur.active:
		select_button.disabled = true
		
		if masseur.active:
			select_button.text = "Active"
		else:
			select_button.text = "Locked"
	else:
		select_button.disabled = false
		select_button.text = "Select"
	
	image.offset_transform_position = IMG_START_POS
	stats_page.offset_transform_position = STAT_START_POS
	
	if tween:
		tween.kill()
	
	tween = create_tween().set_parallel()
	
	tween.tween_property(
		image,
		"offset_transform_position",
		IMG_DEFAULT_POS,
		0.7
	).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(
		stats_page,
		"offset_transform_position",
		Vector2.ZERO,
		0.7
	).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	for button: Button in masseur_buttons.get_children():
		var target_pos: Vector2 = (
			Vector2.ZERO
			if button.button_pressed
			else BTN_START_POS
		)
		
		tween.tween_property(
			button,
			"offset_transform_position",
			target_pos,
			0.2
		).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)


func _on_select_pressed() -> void:
	masseur_selected.emit(selected_masseur.to_lower())
	Global.main.unload_current_pause_scene()
	queue_free()


func _on_cancel_pressed() -> void:
	masseur_selected.emit("")
	Global.main.unload_current_pause_scene()
	queue_free()
