extends Node3D

@onready var money := $SubViewport/Control/MarginContainer/MoneyCountNum

var format_string = "%010d"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money.text = format_string % game_manager.gameplay_instance.capital
	game_manager.gameplay_instance.capital_changed.connect(_update_money)


func _update_money(value: int) -> void:
	money.text = format_string % value
