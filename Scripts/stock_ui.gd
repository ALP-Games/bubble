class_name StockUI
extends Control

@onready var stock_name_label := $MarginContainer/VBoxContainer/StockNameContainer/StockName
@onready var stock_graph := $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/StockGraph

@onready var buy_price_number := $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/BuyPriceNumber
@onready var sell_price_number := $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/SellPriceNumber
@onready var evaluation := $MarginContainer/VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/UnitsPerTransactionNumber

func set_stock_name(name: StringName) -> void:
	stock_name_label.text = name


func set_stock_history(history: Array[int]) -> void:
	stock_graph.stock_prices = history


func set_stock_buy_price(price: int) -> void:
	buy_price_number.text = str(price)


func set_stock_sell_price(price: int) -> void:
	sell_price_number.text = str(price)


func set_evaluation(eval: float) -> void:
	evaluation.text = str(eval)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
