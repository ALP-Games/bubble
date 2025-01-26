class_name GameOver extends Control

@onready var lasted := $VBoxContainer/YouLasted
@onready var retry_button := $VBoxContainer/Button
@export var delay := 1.0
@export var appear := 1.0

var lasted_text: StringName = "You kept the market\nafloat for %s months"


func _ready() -> void:
	game_manager.gameplay_instance.the_end.connect(_display_game_end)
	modulate.a = 0
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE


func _display_game_end() -> void:
	set_score(game_manager.gameplay_instance.score)
	var delay_tween := create_tween()
	delay_tween.tween_callback(func():
		mouse_filter = MouseFilter.MOUSE_FILTER_STOP
		retry_button.pressed.connect(_restart)
		var appear_tween := create_tween()
		appear_tween.tween_property(self, "modulate:a", 1.0, appear)
		appear_tween.tween_callback(func():
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			)).set_delay(delay)


func _restart() -> void:
	game_manager.scene_manager.reload()


func set_score(score: int) -> void:
	lasted.text = lasted_text % score
