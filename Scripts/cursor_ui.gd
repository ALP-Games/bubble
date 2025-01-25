class_name CursorUI
extends Control

@onready var crosshair := $HBoxContainer/Crosshair
@onready var buy_prompt := $HBoxContainer/Prompts/VBoxContainer/BuyPrompt
@onready var sell_prompt := $HBoxContainer/Prompts/VBoxContainer/SellPrompt

@onready var action_prompt := $HBoxContainer/ActionPrompt

var buy_prompt_text := &"[E] to Buy stock"
var sell_prompt_text := &"[R] to Sell stock"

func enable_prompts(buy: bool, sell: bool) -> void:
	action_prompt.text = ""
	if buy:
		action_prompt.text += buy_prompt_text
	if buy and sell:
		action_prompt.text += "\n"
	if sell:
		action_prompt.text += sell_prompt_text
