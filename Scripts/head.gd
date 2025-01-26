extends Node3D

@export_range(0, 180, 0.001, "radians_as_degrees") var max_pitch_degrees: float = deg_to_rad(60)
@export var head_max_rotation_units: Vector2 = Vector2.ZERO

@onready var parent := get_parent()


var handle_input_callable: Callable = _nothing


#TODO export this
const SENSTIVITY: float = 0.003 # has to be modifiable in settings


func _nothing(event: InputEvent) -> void:
	pass


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	game_manager.gameplay_instance.game_over_sequence_start.connect(func()->void:
		handle_input_callable = _handle_up_and_down)
	game_manager.player_instance.ready.connect(func()->void:
		var enable_input := create_tween()
		enable_input.tween_callback(func()->void:handle_input_callable = _handle_mouse_input).\
			set_delay(game_manager.player_instance.wake_up.delay))
	


func _unhandled_input(event: InputEvent) -> void:
	handle_input_callable.call(event)


func _handle_up_and_down(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var rotation = -event.relative * SENSTIVITY
		if head_max_rotation_units.y > 0:
			rotate_x(clamp(rotation.y, -head_max_rotation_units.y, head_max_rotation_units.y))
		else:
			rotate_x(rotation.y)
		self.rotation.x = clamp(self.rotation.x, -max_pitch_degrees, max_pitch_degrees)


func _handle_mouse_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var rotation = -event.relative * SENSTIVITY
		
		if head_max_rotation_units.x > 0:
			# rotate the body
			parent.rotate_y(clamp(rotation.x, -head_max_rotation_units.x, head_max_rotation_units.x))
		else:
			parent.rotate_y(rotation.x)
		if head_max_rotation_units.y > 0:
			rotate_x(clamp(rotation.y, -head_max_rotation_units.y, head_max_rotation_units.y))
		else:
			rotate_x(rotation.y)
		self.rotation.x = clamp(self.rotation.x, -max_pitch_degrees, max_pitch_degrees)
