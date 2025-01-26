class_name Clock
extends Node3D

@export var tick_sounds: Array[AudioStreamOggVorbis]
@export var audio_delay := 0.4
@export var month_dial_increment: float = deg_to_rad(-30)
@export var number_dial_increment: float = deg_to_rad(-36)
@export var year: int = 2035
@export var year_flip_time: float = 0.25

@onready var month_dial := $Clock/Months

@onready var first_digit_dial := $Clock/Numbers2
@onready var second_digit_dial := $Clock/Numbers3
@onready var third_digit_dial := $Clock/Numbers4
@onready var fourth_digit_dial := $Clock/Numbers5


var current_tick_sound: int = 0
var month_counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager.gameplay_instance.clock_interval
	game_manager.gameplay_instance.clock_tick.connect(_tick)
	_set_year()
	_rotate_dial()


func _set_year() -> void:
	var current_num := year
	var current_digit := current_num % 10
	first_digit_dial.rotation.z += current_digit * number_dial_increment
	current_num /= 10
	current_digit = current_num % 10
	second_digit_dial.rotation.z += current_digit * number_dial_increment
	current_num /= 10
	current_digit = current_num % 10
	third_digit_dial.rotation.z += current_digit * number_dial_increment
	current_digit = current_num / 10
	fourth_digit_dial.rotation.z += current_digit * number_dial_increment
	pass
		

func _rotate_dial() -> void:
	var rotation_tween := create_tween()
	rotation_tween.set_trans(Tween.TRANS_ELASTIC)
	rotation_tween.tween_property(month_dial, "rotation:z", month_dial.rotation.z + month_dial_increment, game_manager.gameplay_instance.clock_interval)
	#rotation_tween.tween_callback(_play_audio).set_delay(audio_delay)
	_play_audio()
	month_counter += 1
	if month_counter >= 12:
		month_counter = 0
		_add_year()
		#rotation_tween.tween_callback(_add_year)


func _add_year() -> void:
	var previous_year := year
	year += 1
	var current_year := year
	# check for dial differences
	previous_year /= 10
	current_year /= 10
	var use_second_digit := previous_year % 10 != current_year % 10
	previous_year /= 10
	current_year /= 10
	var use_third_digit := previous_year % 10 != current_year % 10
	previous_year /= 10
	current_year /= 10
	var use_fourth_digit := previous_year % 10 != current_year % 10
	
	var first_tween := _create_number_spin_tween(first_digit_dial)
	if use_second_digit:
		first_tween.tween_callback(func()->void:
			var second_tween := _create_number_spin_tween(second_digit_dial)
			if use_third_digit:
				second_tween.tween_callback(func()->void:
					var third_tween := _create_number_spin_tween(third_digit_dial)
					if use_fourth_digit:
						third_tween.tween_callback(func()->void:
							_create_number_spin_tween(fourth_digit_dial))))
	#if use_second_digit:


func _create_number_spin_tween(number_dial: Node3D) -> Tween:
	var number_tween := create_tween()
	number_tween.set_trans(Tween.TRANS_BACK)
	number_tween.tween_property(number_dial, "rotation:z", number_dial.rotation.z + number_dial_increment, year_flip_time)
	return number_tween


func _play_audio() -> void:
	var audio := AudioStreamPlayer3D.new()
	add_child(audio)
	audio.stream = tick_sounds[current_tick_sound]
	current_tick_sound += 1
	if current_tick_sound >= tick_sounds.size():
		current_tick_sound = 0
	var audio_tween := create_tween()
	audio_tween.tween_callback(func()->void: audio.play()).set_delay(audio_delay)
	audio.finished.connect(func()->void:
		audio.queue_free())


func _tick() -> void:
	_rotate_dial()
