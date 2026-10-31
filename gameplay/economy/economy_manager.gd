extends Node
class_name EconomyManager

signal coins_updated(amount: float)

var coins: float = 0

func set_revenue(amount: float) -> void:
	coins += amount
	coins_updated.emit(coins)
