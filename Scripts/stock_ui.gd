class_name StockUI
extends Control

@onready var stock_name_label := $HBoxContainer/VBoxContainer2/StockNameContainer/StockName


func set_stock_name(name: StringName) -> void:
	stock_name_label.text = name


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
