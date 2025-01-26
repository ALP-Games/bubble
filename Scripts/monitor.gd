class_name Monitor
extends Node3D

@onready var stock_ui := $SubViewport/StockUI
var stock_ref: StockSimulated


func set_stock_name(name: StringName) -> void:
	stock_ui.set_stock_name(name)


func set_stock_ref(stock: StockSimulated) -> void:
	stock_ref = stock
	stock_ref.stock_died.connect(_on_stock_died)


func _on_stock_died() -> void:
	$SubViewport/TurnOff.turn_off()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stock_ref == null:
		return
	stock_ui.set_stock_history(stock_ref.price_history)
	stock_ui.set_stock_buy_price(stock_ref.buy_price)
	stock_ui.set_stock_sell_price(stock_ref.sell_price)
	stock_ui.set_units_owned(stock_ref.stock_owned)
	stock_ui.set_evaluation(stock_ref.evaluation)
