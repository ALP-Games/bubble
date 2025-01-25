class_name StockSimulated
extends Resource

enum State {
	NORMAL,
	RUPTURE
}

var MAX_HISTORY := 10

@export var name: StringName = "Detcla"

# per share
@export var earnings: float = 10
@export var _earnings_growth: float = 0.1
@export var _earnings_decline: float = 0.05

@export var overevaluation_bias: float = 30
@export var stock_price: int = 100
@export var _price_growth: int = 2
@export var _price_decline: int = 1

var buy_price: int
var sell_price: int

var _state: State = State.NORMAL

var evaluation: float

var price_history: Array[int] = []


func update() -> void:
	if _state == State.NORMAL:
		stock_price += randi_range(-_price_decline, _price_growth)
		earnings += randf_range(-_earnings_decline, _earnings_growth)
		buy_price = stock_price * randf_range(1.0, 1.1)
		sell_price = stock_price * randf_range(0.9, 1.0)
		evaluation = stock_price / earnings
		
	elif _state == State.RUPTURE:
		pass
	
	if price_history.size() >= MAX_HISTORY:
		price_history.pop_front()  # Remove the oldest value
	price_history.append(stock_price)
