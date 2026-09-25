@tool
extends Node2D

@export var health: int = 10:
	set(value):
		health = value
		queue_redraw()
@export var max_health: int = 10
@export var width: int = 80
@export var height: int = 10
@export var y_offset: int = -20


func _draw() -> void:
	if health >= max_health and not Engine.is_editor_hint():
		return

	var x_offset = -width / 2.0
	# background bar
	draw_rect(Rect2(x_offset, y_offset, width, height), Color(0.15, 0.15, 0.15))
	# fill proportional to remaining health
	var ratio := clampf(float(health) / max_health, 0.0, 1.0)
	draw_rect(Rect2(x_offset, y_offset, width * ratio, height), Color(0.2, 1.0, 0.3))
