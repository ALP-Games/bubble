class_name Player
extends Node3D

@export var crosshair_fade_duration: float = 0.1

@onready var raycast := $Head/Eyes/RayCast3D
@onready var crosshair_ui := $SubViewport/PlayerCharacterUI


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collider := raycast.get_collider() as Node
	if collider != null and collider is Monitor:
		var monitor: Monitor = collider 
		var crosshair_tween := create_tween()
		crosshair_tween.tween_property(crosshair_ui.crosshair, "modulate:a", 1.0, crosshair_fade_duration)
		
		var can_buy := game_manager.gameplay_instance.capital >= monitor.stock_ref.buy_price
		var can_sell := monitor.stock_ref.stock_owned > 0
		
		if can_buy or can_sell:
			var action_tween := create_tween()
			action_tween.tween_property(crosshair_ui.action_prompt, "modulate:a", 1.0, crosshair_fade_duration)
			crosshair_ui.enable_prompts(can_buy, can_sell)
		
		if Input.is_action_just_pressed("buy") and can_buy:
			game_manager.gameplay_instance.capital = monitor.stock_ref.buy_stock(game_manager.gameplay_instance.capital)
		
		if Input.is_action_just_pressed("sell") and can_sell:
			game_manager.gameplay_instance.capital = monitor.stock_ref.sell_stock(game_manager.gameplay_instance.capital)
		
	else:
		var crosshair_tween := create_tween()
		crosshair_tween.tween_property(crosshair_ui.crosshair, "modulate:a", 0.0, crosshair_fade_duration)
		var action_tween := create_tween()
		action_tween.tween_property(crosshair_ui.action_prompt, "modulate:a", 0.0, crosshair_fade_duration)