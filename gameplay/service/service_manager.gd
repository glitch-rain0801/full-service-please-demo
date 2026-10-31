extends Node
class_name ServiceManager

func check_used_masseur(masseur_id: String) -> bool:
	var world_map: WorldMap = Global.main.get_current_world_scene()
	if world_map is not WorldMap:
		push_error("Returned node is not of type 'WorldMap'")
		return false
	
	var service_area: ServiceArea = world_map.get_service_area()
	for room: MassageRoom in service_area.get_rooms():
		if not is_instance_valid(room.current_masseur):
			continue
		
		if room.current_masseur.id == masseur_id:
			print('Hello')
			return true
	
	return false

func set_usable_masseurs(week: int) -> void:
	var count: int = 0
	
	for masseur_id in Entities.masseurs:
		var masseur: MasseurData = Entities.masseurs[masseur_id]
		if week <=2 and count >= 4:
			masseur.unlocked = false
		elif week <= 4 and count >= 5:
			masseur.unlocked = false
		else:
			masseur.unlocked = true
		
		count += 1


func set_working_masseur() -> MasseurData:
	Global.main.load_to_pause_node("res://ui/assign_masseur/assign_masseur_ui.tscn")
	
	var assign_masseur_ui: AssignMasseurUI = Global.main.get_current_pause_scene()
	if assign_masseur_ui is not AssignMasseurUI:
		push_error("Returned node is not of type 'AssignMasseurUI'")
		return
	
	var masseur: String = await assign_masseur_ui.masseur_selected
	
	if masseur == "":
		return null
	
	return Entities.masseurs[masseur]
