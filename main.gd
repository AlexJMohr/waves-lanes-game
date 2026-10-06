extends Node2D


func _ready() -> void:
	$UI.buy_requested.connect(_on_buy_requested)


func _on_buy_requested(data: UnitData) -> void:
	if GameState.spend(data.cost):
		$Lane.spawn(Unit.Team.PLAYER, data)
