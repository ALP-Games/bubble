class_name PrototypeUI
extends Control

@onready var money := $VBoxContainer/Label

@export var gameplay: Gameplay

var format_string = "%s$"

# Called when the node enters the scene tree for the first time.
func _ready():
	#money.text = str(gameplay.capital)
	money.text = format_string % gameplay.capital
	gameplay.capital_changed.connect(_update_money)


func _update_money(value: int) -> void:
	money.text = format_string % value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
