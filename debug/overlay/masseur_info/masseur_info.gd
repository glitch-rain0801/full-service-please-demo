extends PanelContainer
class_name MasseurInfo

@export var id_label: Label
@export var service_time_label: Label
@export var service_cost_label: Label
@export var speciality_bonus_label: Label
@export var max_energy_label: Label
@export var energy_gain_label: Label
@export var energy_cost_label: Label
@export var refill_time_label: Label
@export var affinity_yield_label: Label
@export var affinity_bonus_label: Label
@export var relief_chance_label: Label
@export var relief_time_label: Label
@export var relief_bonus_label: Label
@export var relief_cost_label: Label

func update_masseur_statistics(masseur: MasseurData) -> void:
	id_label.text = "Masseur Name: " + str(masseur.name)
	service_time_label.text = "Service Time: " + str(masseur.base_service_time)
	service_cost_label.text = "Service Cost: " + str(masseur.base_service_cost)
	speciality_bonus_label.text = "Speciality Bonus: " + str(masseur.base_speciality_bonus)
	max_energy_label.text = "Max Energy: " + str(masseur.base_max_energy)
	energy_gain_label.text = "Energy Gain: " + str(masseur.base_energy_gain)
	energy_cost_label.text = "Energy Cost: " + str(masseur.base_energy_cost)
	refill_time_label.text = "Refill Time: " + str(masseur.base_energy_refill_time)
	affinity_bonus_label.text = "Affinity Bonus: " + str(masseur.base_affinity_bonus)
	affinity_yield_label.text = "Affinity Yield: " + str(masseur.base_affinity_yield)
	relief_chance_label.text = "Relief Chance: " + str(masseur.base_relief_chance)
	relief_time_label.text = "Relief Time: " + str(masseur.base_relief_time)
	relief_bonus_label.text = "Relief Bonus: " + str(masseur.base_relief_bonus)
	relief_cost_label.text = "Relief Cost: " + str(masseur.base_service_cost)
