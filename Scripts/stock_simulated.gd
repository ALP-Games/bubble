class_name StockSimulated
extends Resource

enum State {
	NORMAL,
	RUPTURE
}

var MAX_HISTORY := 20

@export var name: StringName = "Detcla"

# per share
@export var earnings: float = 10
@export var _earnings_growth: float = 0.1
@export var _earnings_decline: float = 0.05

@export var overevaluation_bias: float = 30
@export var stock_price: float = 100
@export var _price_growth: float = 2
@export var _price_decline: float = 1

var buy_price: int
var sell_price: int

var _state: State = State.NORMAL

var evaluation: float

var price_history: Array[float] = []


func update() -> void:
	if _state == State.NORMAL:
		stock_price += randf_range(-_price_decline, _price_growth)
		earnings += randf_range(-_earnings_decline, _earnings_growth)
		buy_price = stock_price * randf_range(1.0, 1.1)
		sell_price = stock_price * randf_range(0.9, 1.0)
		
	elif _state == State.RUPTURE:
		stock_price -= randf_range(_price_decline, _price_decline + _price_growth)
		earnings -= randf_range(_earnings_decline, _earnings_decline + _earnings_growth)
		if stock_price < 0:
			stock_price = 0
		buy_price = stock_price * randf_range(1.0, 1.1)
		sell_price = stock_price * randf_range(0.9, 1.0)
			# should notify that it died
	
	if price_history.size() >= MAX_HISTORY:
		price_history.pop_front()  # Remove the oldest value
	price_history.append(stock_price)
	
	evaluation = stock_price / earnings
	if evaluation > overevaluation_bias:
		_state = State.RUPTURE
