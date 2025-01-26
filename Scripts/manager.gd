class_name Manager
extends Node

signal player_set

var player_instance: Player = null:
	set(value):
		player_instance = value
		player_set.emit()
var gameplay_instance: Gameplay = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
