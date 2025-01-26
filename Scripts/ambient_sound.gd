class_name AmbientSound
extends AudioStreamPlayer3D

@export var ambient_sounds: Array[AudioStreamOggVorbis]

func _enter_tree() -> void:
	game_manager.ambient_sounds.append(self)


func play_random_sound() -> void:
	var audio := AudioStreamPlayer3D.new()
	audio.global_transform = global_transform
	add_child(audio)
	var current_sound := randi_range(0.0, ambient_sounds.size() - 1)
	audio.stream = ambient_sounds[current_sound]
	audio.play()
	audio.finished.connect(func()->void:
		audio.queue_free())
