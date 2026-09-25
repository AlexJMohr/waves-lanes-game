@tool
extends Node2D

signal destroyed()

var max_health: int = 100
var health: int = 100

@export var color := Color(0.3, 0.6, 1.0):
	set(value):
		color = value
		if is_node_ready():
			$Body.color = value


func _ready() -> void:
	$Body.color = color
	$HealthBar.max_health = max_health
	$HealthBar.health = health
