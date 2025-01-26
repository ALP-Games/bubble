extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager.gameplay_instance.the_end.connect(func():
		queue_free())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
