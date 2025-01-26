class_name SceneManager
extends Node3D

@onready var black_out := $ColorRect
@export var level: PackedScene

var level_instance: Level = null


func _enter_tree() -> void:
	game_manager.scene_manager = self


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_instance = level.instantiate()
	add_child(level_instance)
	black_out.modulate.a = 0


func reload() -> void:
	black_out.modulate.a = 1.0
	#remove_child(level_instance)
	level_instance.pre_deleted.connect(func():
		level_instance = level.instantiate()
		add_child(level_instance)
		black_out.modulate.a = 0)
	level_instance.queue_free()
