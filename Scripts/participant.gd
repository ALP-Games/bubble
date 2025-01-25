class_name Participant
extends RefCounted


var capital: int
# needs reference to all the stocks


func _init(startinc_capital: int) -> void:
	capital = startinc_capital
