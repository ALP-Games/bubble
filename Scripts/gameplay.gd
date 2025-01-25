class_name Gameplay
extends Node

signal capital_changed(int)

# Stock Name and Target monitor
@export var capital: int = 100000000:
	set(value):
		capital = value
		capital_changed.emit(capital)
@export var stock_configuration: Dictionary
@export var tick_delay: float = 1.0

#var participant_delay
var elapsed_time: float = 0

var stocks: Array[StockSimulated] = []

# Detcla
# Bobing
# Shlamantese
# Orange | Watermelon | Pear
# Healthcare | Big Pharam
# Org4n5 | Children
# Proto | Infra


# Called when the node enters the scene tree for the first time.
func _ready():
	var initial_owned_stocks: Dictionary
	for key in stock_configuration:
		var configuration := stock_configuration[key] as Dictionary
		var monitor := get_node(configuration["Monitor"]) as Monitor
		var stock := configuration["Stock"] as StockSimulated
		stocks.append(stock)
		monitor.set_stock_name(key)
		monitor.set_stock_ref(stock)
		for i in 10:
			stock.update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
	if elapsed_time < tick_delay:
		return
	elapsed_time -= tick_delay
	
	for stock in stocks:
		stock.update()
