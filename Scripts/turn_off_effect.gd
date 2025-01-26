extends ColorRect

@export var time_to_turn_off: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func turn_off() -> void:
	var wake_up_tween = create_tween()
	var starting_radius: float = (material as ShaderMaterial).get_shader_parameter("effect_radius")
	wake_up_tween.tween_method(_update_shader, starting_radius, 0.0, time_to_turn_off)
	wake_up_tween.set_trans(Tween.TRANS_EXPO)


func _update_shader(radius: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("effect_radius", radius)
