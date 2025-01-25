class_name Gameplay
extends Node

# Stock Name and Target monitor
@export var starting_capital: int = 1000000
@export var stock_configuration: Dictionary
@export var market_participant_count: int = 500
@export var participants_capital: int = 1000000

var market_participants: Array[Participant]


# Called when the node enters the scene tree for the first time.
func _ready():
	for key in stock_configuration:
		var monitor := get_node(stock_configuration[key]) as Monitor
		monitor.set_stock_name(key)
	
	for index in market_participant_count:
		var ptc_starting_capital := participants_capital / market_participant_count
		market_participants.append(Participant.new(ptc_starting_capital))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
