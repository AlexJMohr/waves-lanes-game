extends CanvasLayer

@onready var money_label: Label = $MoneyLabel


func _ready() -> void:
	money_label.text = _format_money(GameState.money)
	GameState.money_changed.connect(_on_money_changed)


func _on_money_changed(new_value: int) -> void:
	money_label.text = _format_money(new_value)


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
