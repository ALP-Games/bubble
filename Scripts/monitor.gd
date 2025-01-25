class_name Monitor
extends Node3D

@onready var stock_ui := $SubViewport/StockUI


func set_stock_name(name: StringName) -> void:
	stock_ui.set_stock_name(name)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
