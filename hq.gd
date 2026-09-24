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


func _draw() -> void:
	# background bar
	draw_rect(Rect2(-10, -20, 80, 8), Color(0.15, 0.15, 0.15))
	# fill proportional to remaining health
	var ratio := float(health) / max_health
	draw_rect(Rect2(-10, -20, 80 * ratio, 8), Color(0.2, 1.0, 0.3))
