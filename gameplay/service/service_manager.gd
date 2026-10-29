extends Node
class_name ServiceManager


func set_working_masseur() -> MasseurData:
	Global.main.load_to_pause_node("res://ui/assign_masseur/assign_masseur_ui.tscn")
	
	var assign_masseur_ui: AssignMasseurUI = Global.main.get_current_pause_scene()
	if assign_masseur_ui is not AssignMasseurUI:
		push_error("Returned node is not of type 'AssignMasseurUI'")
		return
	
	var masseur: String = await assign_masseur_ui.masseur_selected
	return Entities.masseurs[masseur]
