extends Node

signal money_changed(new_value: int)

var money: int = 0
var tick_interval: float = 1.0
var income_per_tick: int = 1


func _ready() -> void:
	print_debug("GameState autoloaded")
	var timer := Timer.new()
	timer.wait_time = tick_interval
	timer.timeout.connect(_on_income_tick)
	add_child(timer)
	timer.start()


func _on_income_tick() -> void:
	money += income_per_tick
	money_changed.emit(money)
