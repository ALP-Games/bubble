class_name Gameplay
extends Node

# Stock Name and Target monitor
@export var starting_capital: int = 100000000
@export var stock_configuration: Dictionary
@export var market_participant_count: int = 500
@export var participants_capital: int = 100000000

var market_participants: Array[Participant]

#var participant_delay
var elapsed_time: float = 0
var tick_delay: float = 1.0


var stocks: Dictionary

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
		var stock := Stock.new(key)
		stocks[key] = stock
		var monitor := get_node(stock_configuration[key]) as Monitor
		monitor.set_stock_name(key)
		monitor.set_stock_ref(stock)
		initial_owned_stocks[key] = 0
	
		
	
	for index in market_participant_count:
		var ptc_starting_capital := participants_capital / market_participant_count
		market_participants.append(Participant.new(ptc_starting_capital,\
			stocks, initial_owned_stocks.duplicate()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed_time += delta
	if elapsed_time < tick_delay:
		return
	elapsed_time -= tick_delay
	
	for key in stocks:
		(stocks[key] as Stock).update()
	
	for participant in market_participants:
		participant.update()
