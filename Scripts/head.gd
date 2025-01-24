extends Node3D

@export_range(0, 180, 0.001, "radians_as_degrees") var max_pitch_degrees: float = deg_to_rad(60)
@export var head_max_rotation_units: Vector2 = Vector2.ZERO

@onready var parent := get_parent()


#TODO export this
const SENSTIVITY: float = 0.003 # has to be modifiable in settings


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
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
