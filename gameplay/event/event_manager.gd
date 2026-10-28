extends Node
class_name EventManager

enum PerkType { ITEMS, PASSIVES, MIXED }

class PerkCategory extends RefCounted:
	const ITEMS: String = "items"
	const PASSIVES: String = "passives"
	const MIXED: Array = [ITEMS, PASSIVES]
	
	func get_category_pool(perk_type: PerkType) -> Variant:
		match perk_type:
			PerkType.ITEMS:
				return ITEMS
			PerkType.PASSIVES:
				return PASSIVES
		
		return MIXED

const NO_PERK: Dictionary = { "name": null }

var categories: PerkCategory = PerkCategory.new()

func get_workshift_perk(time: GameManager.GameTime, perk_type: PerkType = PerkType.MIXED) -> Dictionary:
	var selected_perk: Dictionary = {}
	
	var pool: Variant = categories.get_category_pool(perk_type)
	var slots: int = _get_perk_slots(time)
	var choices: Array = _generate_perk_choices(slots, pool)
	
	Global.main.load_to_pause_node(
		"res://ui/perk_selection/perk_selection_ui.tscn",
		{ "options": choices }
	)
	
	var perk_selection_ui: PerkSelectionUI = Global.main.get_current_pause_scene()
	var perk = await perk_selection_ui.perk_selected
	
	return NO_PERK


func _get_perk_slots(time: GameManager.GameTime) -> int:
	var week: int = time.week
	var day: int = time.day
	var shift: String = time.shift
	
	if week >= 4:
		return 3
	if week >= 2:
		return 2
	if week == 1:
		return 2 if day >= 4 else 1
	if week == 0:
		if day == 6 or (day == 5 and shift == GameManager.Shift.MORNING):
			return 1
	
	return 0


func _generate_perk_choices(slots: int, options: Variant) -> Array:
	var choices: Array = []
		
	for i in range(slots):
		if options is Array:
			var chosen: String = options.pick_random()
			choices.append(chosen)
		else:
			choices.append(options)
	
	return choices
