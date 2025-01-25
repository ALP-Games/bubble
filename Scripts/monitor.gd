class_name Monitor
extends Node3D

@onready var stock_ui := $SubViewport/StockUI
var _stock_ref: StockSimulated


func set_stock_name(name: StringName) -> void:
	stock_ui.set_stock_name(name)


func set_stock_ref(stock: StockSimulated) -> void:
	_stock_ref = stock


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _stock_ref == null:
		return
	stock_ui.set_stock_history(_stock_ref.price_history)
	stock_ui.set_stock_buy_price(_stock_ref.buy_price)
	stock_ui.set_stock_sell_price(_stock_ref.sell_price)
	stock_ui.set_evaluation(_stock_ref.evaluation)
