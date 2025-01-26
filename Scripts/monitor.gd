class_name Monitor
extends Node3D

@export var turn_off_audio: AudioStreamOggVorbis

@onready var stock_ui := $SubViewport/StockUI
var stock_ref: StockSimulated

var update_stock_graphics: Callable = _nothing


func _nothing() -> void:
	pass


func set_stock_name(name: StringName) -> void:
	stock_ui.set_stock_name(name)


func set_stock_ref(stock: StockSimulated) -> void:
	stock_ref = stock
	update_stock_graphics = _update_stock_render
	stock_ref.stock_updated.connect(_update_stock_render)
	stock_ref.stock_died.connect(_on_stock_died)


func _on_stock_died() -> void:
	update_stock_graphics = _nothing
	stock_ref.stock_died.disconnect(_on_stock_died)
	_play_turn_off_sound()
	$SubViewport/TurnOff.turn_off()


func _play_turn_off_sound() -> void:
	var audio := AudioStreamPlayer3D.new()
	add_child(audio)
	audio.stream = turn_off_audio
	var audio_tween := create_tween()
	audio_tween.tween_callback(func()->void: audio.play())
	audio.finished.connect(func()->void:
		audio.queue_free())


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _update_stock_render() -> void:
	stock_ui.set_stock_history(stock_ref.price_history)
	stock_ui.set_stock_buy_price(stock_ref.buy_price)
	stock_ui.set_stock_sell_price(stock_ref.sell_price)
	stock_ui.set_units_owned(stock_ref.stock_owned)
	stock_ui.set_evaluation(stock_ref.evaluation)


func _process(_delta: float) -> void:
	update_stock_graphics.call()
