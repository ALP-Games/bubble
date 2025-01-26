extends ColorRect

@export var target_vision: float = 6.3
@export var delay: float = 0.5
@export var time: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var delay_tween = create_tween()
	delay_tween.tween_callback(func()->void:
		var wake_up_tween = create_tween()
		wake_up_tween.tween_method(_update_shader, 0.0, target_vision, time)
		wake_up_tween.set_trans(Tween.TRANS_EXPO)).set_delay(delay)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _update_shader(radius: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("radius", radius)
