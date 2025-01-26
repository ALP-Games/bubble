extends Control


@export var delay: float = 0.2


func _enter_tree() -> void:
	var remove_tween = create_tween()
	remove_tween.tween_callback(func()->void:
		queue_free()).set_delay(delay)
