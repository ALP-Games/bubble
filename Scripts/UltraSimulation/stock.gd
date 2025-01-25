class_name Stock
extends RefCounted

var MAX_HISTORY := 10

var stock_name: StringName
var price_history: Array[int] = []
var buy_price: int
var stock_price: int
var sell_price: int
var total_shares: float
var purchased_shares: float

var total_capital: int
# could be a paramete
var target_capital: int

var price_to_earning: float

var earnings: int
# could be some kind of growth
var growth_index: float = 1.5
var decline_index: float = 0.5

var unit_difference: float
var price_growth_per_difference: float = 0.


func _init(name: StringName) -> void:
	stock_price = 100
	earnings = 30000
	price_history.append(10)
	price_history.append(stock_price)
	stock_name = name
	total_shares = 1000
	update()


func update() -> void:
	if unit_difference != 0:
		var price_growth: float = (total_shares - purchased_shares) / abs(unit_difference)
		stock_price *= price_growth
	unit_difference = 0
	earnings *= randf_range(decline_index, growth_index)
	buy_price = stock_price * randf_range(1.0, 1.05)
	sell_price = stock_price * randf_range(0.95, 1.0)
	price_to_earning = stock_price / (earnings / total_shares)
	
	# Simulate stock price changes (add a random value)
	if price_history.size() >= MAX_HISTORY:
		price_history.pop_front()  # Remove the oldest value
	price_history.append(stock_price)


func get_purchase_price(units: float) -> int:
	units = min((total_shares - purchased_shares), units)
	return units * buy_price


func buy_stock(money: int) -> float:
	var units := money / buy_price
	units = min((total_shares - purchased_shares), units)
	total_capital += money
	purchased_shares += units
	unit_difference -= units
	return units


func get_sell_price(units: float) -> int:
	return units * sell_price


func sell_stock(money: int) -> float:
	var units := money / sell_price
	total_capital -= money
	purchased_shares -= units
	unit_difference += units
	return units


func get_evaluation() -> float:
	return price_to_earning


#func create_sell_order(units: float, price: int) -> void:
	#if ledger[price]:
		#ledger[price] += units
	#else :
		#ledger[price] = units
		#
#func create_buy_order()
