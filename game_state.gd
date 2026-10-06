extends Node

signal money_changed(new_value: int)

var money: int = 0
var tick_interval: float = 1.0
var income_per_tick: int = 1

const KILL_REWARD_FRACTION := 0.5


func _ready() -> void:
	print_debug("GameState autoloaded")
	var timer := Timer.new()
	timer.wait_time = tick_interval
	timer.timeout.connect(_on_income_tick)
	add_child(timer)
	timer.start()


func _on_income_tick() -> void:
	add_money(income_per_tick)


func add_money(amount: int):
	money += amount
	money_changed.emit(money)


func spend(amount: int) -> bool:
	if money < amount:
		return false
	money -= amount
	money_changed.emit(money)
	return true
