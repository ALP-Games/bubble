class_name Manager
extends Node

signal player_set

var player_instance: Player = null:
	set(value):
		player_instance = value
		player_set.emit()
var gameplay_instance: Gameplay = null
var ambient_sounds: Array[AmbientSound]
var delay_from: float = 3.0
var delay_up_to: float = 10.0

var current_delay: float = 0.0
var ambient_sound_delay_elapsed: float = 0.0

var process_ambient_sounds: Callable = _process_ambient_sound

# Called when the node enters the scene tree for the first time.
func _ready():
	gameplay_instance.the_end.connect(func()->void:process_ambient_sounds=func(delta: float):pass)
	current_delay = randf_range(delay_from, delay_up_to)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_ambient_sounds.call(delta)


func _process_ambient_sound(delta: float) -> void:
	ambient_sound_delay_elapsed += delta
	if ambient_sound_delay_elapsed >= current_delay:
		ambient_sound_delay_elapsed -= current_delay
		current_delay = randf_range(delay_from, delay_up_to)
		var sound_pos := randi_range(0, ambient_sounds.size() - 1)
		ambient_sounds[sound_pos].play_random_sound()
