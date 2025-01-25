class_name Participant
extends RefCounted


var capital: int
var stocks_ref: Dictionary

var owned_stocks: Dictionary

var evaluation_bias: float


func _init(startinc_capital: int, stocks: Dictionary,\
	initial_owned: Dictionary) -> void:
	capital = startinc_capital
	stocks_ref = stocks
	owned_stocks = initial_owned
	evaluation_bias = randf_range(10, 50)


func update() -> void:
	for key in owned_stocks:
		var stock := stocks_ref[key] as Stock
		if stock.get_evaluation() < evaluation_bias:
			var owned: float = owned_stocks[key]
			var sell_price := stock.get_sell_price(owned_stocks[key])
			if sell_price != 0:
				owned_stocks[key] -= stock.sell_stock(sell_price)
	
	var prefered_stock: Stock
	for key in stocks_ref:
		var current_stock := stocks_ref[key] as Stock
		if current_stock.get_evaluation() >= evaluation_bias:
			if prefered_stock == null:
				prefered_stock = current_stock
			elif prefered_stock.get_evaluation() > current_stock.get_evaluation():
				prefered_stock = current_stock
	if prefered_stock != null:
		var price := prefered_stock.get_purchase_price(1)
		if price <= capital:
			owned_stocks[prefered_stock.stock_name] += prefered_stock.buy_stock(price)
