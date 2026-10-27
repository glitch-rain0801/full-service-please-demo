extends Node2D
class_name ServiceArea

@export var massage_rooms: Node2D

func set_useable_rooms(week: int) -> void:
	var count: int = 0
	for room: MassageRoom in massage_rooms.get_children():
		if week <=2 and count >= 4:
			room.set_availability(false)
		elif week <= 4 and count >= 5:
			room.set_availability(false)
		else:
			room.set_availability(true)
		
		count += 1
