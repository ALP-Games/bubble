class_name Level
extends Node3D

signal pre_deleted


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		pre_deleted.emit()
