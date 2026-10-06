extends CanvasLayer

signal buy_requested(data: UnitData)

@onready var money_label: Label = $MoneyLabel
@onready var melee_button: Button = $MeleeButton
@onready var ranged_button: Button = $RangedButton

const MELEE_DATA := preload("res://melee_unit.tres")
const RANGED_DATA := preload("res://ranged_unit.tres")


func _ready() -> void:
	money_label.text = _format_money(GameState.money)
	GameState.money_changed.connect(_on_money_changed)
	_setup_button(melee_button, MELEE_DATA)
	_setup_button(ranged_button, RANGED_DATA)
	_refresh_buttons()


func _on_money_changed(new_value: int) -> void:
	money_label.text = _format_money(new_value)
	_refresh_buttons()


func _format_money(value: int) -> String:
	var s := str(value)
	var result := ""
	var i := s.length() - 1
	var count := 0
	while i >= 0:
		result = s[i] + result
		count += 1
		if count % 3 == 0 and i > 0:
			result = "," + result
		i -= 1
	return "$" + result


func _setup_button(button: Button, data: UnitData) -> void:
	button.pressed.connect(
		func():
			buy_requested.emit(data),
	)
	button.text = data.display_name + " (" + _format_money(data.cost) + ")"


func _refresh_buttons() -> void:
	melee_button.disabled = GameState.money < MELEE_DATA.cost
	ranged_button.disabled = GameState.money < RANGED_DATA.cost
