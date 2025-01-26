class_name Gameplay
extends Node

signal capital_changed(int)
signal clock_tick
signal game_over_sequence_start
signal the_end

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
@export var bubble_pop_sound: AudioStreamOggVorbis
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


func _enter_tree() -> void:
	game_manager.gameplay_instance = self


# Called when the node enters the scene tree for the first time.
func _ready():
	the_end.connect(_play_sound_at_bubble.bind(bubble_pop_sound))
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
	if stocks.is_empty():
		_game_over_sequence()
	if dead_stock_queue.size() < 1:
		return
	if bubble_tween != null:
		return
	bubble_tween = create_tween()
	bubble_tween.set_trans(Tween.TRANS_LINEAR)
	bubble_tween.tween_property(bubble, "scale", bubble.scale + _bubble_growth, bubble_growth_sound.get_length())
	bubble_tween.tween_callback(func()->void:
		dead_stock_queue.pop_back()
		bubble_tween = null
		if stocks.is_empty():
			the_end.emit())
	if not stocks.is_empty():
		_play_sound_at_bubble(bubble_growth_sound)


func _play_sound_at_bubble(sound: AudioStreamOggVorbis) -> void:
	var audio := AudioStreamPlayer3D.new()
	audio.global_transform = bubble.global_transform
	bubble.add_child(audio)
	audio.stream = sound
	audio.play()
	var kill = func(steam_player: AudioStreamPlayer3D)->void:
		steam_player.stop()
		steam_player.queue_free()
	audio.finished.connect(func()->void:
		the_end.disconnect(kill))
	audio.finished.connect(kill.bind(audio))
	the_end.connect(kill.bind(audio))

#var bubble_tween
func _game_over_sequence() -> void:
	game_over_sequence_start.emit()
	var direction = (bubble.global_position - game_manager.player_instance.global_position).normalized()
	var rotation := game_manager.player_instance.global_rotation
	var target_angle := direction.angle_to(Vector3.FORWARD)
	var rotate_tween := create_tween()
	rotate_tween.tween_property(game_manager.player_instance, "global_rotation:y", target_angle, 1.0)
	#game_manager.player_instance.look_at(bubble.global_position)


func _on_stock_died(stock: StockSimulated) -> void:
	stocks.erase(stock)
	dead_stock_queue.append(stock)
