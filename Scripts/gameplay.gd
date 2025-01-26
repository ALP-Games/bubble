class_name Gameplay
extends Node

signal capital_changed(int)
signal clock_tick

# Stock Name and Target monitor
@export var capital: int = 100000000:
	set(value):
		capital = value
		capital_changed.emit(capital)
@export var stock_configuration: Dictionary
@export var tick_delay: float = 1.0
@export var clock_interval: float = 1.0

@export var bubble: Node3D
@export var bubble_growth_sound: AudioStreamOggVorbis
@export var bubble_size_increment: float = 0.45:
	set(value):
		_bubble_growth = Vector3(value, value, value)
var _bubble_growth: Vector3 = Vector3(0.45, 0.45, 0.45)

#var participant_delay
var elapsed_time: float = 0
var clock_time_elasped: float = 0

var stocks: Array[StockSimulated] = []

var dead_stock_queue: Array[StockSimulated]

# Detcla
# Bobing
# Shlamantese
# Orange | Watermelon | Pear
# Healthcare | Big Pharam
# Org4n5 | Children
# Proto | Infra


# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.gameplay_instance = self
	var initial_owned_stocks: Dictionary
	for key in stock_configuration:
		var configuration := stock_configuration[key] as Dictionary
		var monitor := get_node(configuration["Monitor"]) as Monitor
		var stock := configuration["Stock"] as StockSimulated
		stock.stock_died.connect(_on_stock_died.bind(stock))
		stocks.append(stock)
		monitor.set_stock_name(key)
		monitor.set_stock_ref(stock)
		for i in 10:
			stock.update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_process_dead_stock_queue()
	clock_time_elasped += delta
	if clock_time_elasped >= clock_interval:
		clock_time_elasped -= clock_interval
		clock_tick.emit()
	
	elapsed_time += delta
	if elapsed_time < tick_delay:
		return
	elapsed_time -= tick_delay
	
	for stock in stocks:
		stock.update()

var bubble_tween: Tween = null

func _process_dead_stock_queue() -> void:
	if dead_stock_queue.size() < 1:
		return
	if bubble_tween != null:
		return
	bubble_tween = create_tween()
	bubble_tween.set_trans(Tween.TRANS_LINEAR)
	bubble_tween.tween_property(bubble, "scale", bubble.scale + _bubble_growth, bubble_growth_sound.get_length())
	bubble_tween.tween_callback(func()->void:
		dead_stock_queue.pop_back()
		bubble_tween = null)
	_play_bubble_sound()


func _play_bubble_sound() -> void:
	var audio := AudioStreamPlayer3D.new()
	audio.global_transform = bubble.global_transform
	bubble.add_child(audio)
	audio.stream = bubble_growth_sound
	audio.play()
	audio.finished.connect(func()->void:
		audio.queue_free())

#var bubble_tween


func _on_stock_died(stock: StockSimulated) -> void:
	stocks.erase(stock)
	dead_stock_queue.append(stock)
