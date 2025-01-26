class_name SceneManager
extends Node3D

@export var level: PackedScene

var level_instance: Node = null


func _enter_tree() -> void:
	game_manager.scene_manager = self


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_instance = level.instantiate()
	add_child(level_instance)


func reload() -> void:
	remove_child(level_instance)
	level_instance.queue_free()
	level_instance = level.instantiate()
	add_child(level_instance)
