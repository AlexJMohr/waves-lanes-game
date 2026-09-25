extends Node2D

const UNIT_SCENE := preload("res://unit.tscn")


# TEMPORARY: spawns test units. Delete this once the real buy/spawn flow exists.
func _ready() -> void:
	_spawn(Unit.Team.PLAYER, $PlayerSpawn.position, 3)
	_spawn(Unit.Team.ENEMY, $EnemySpawn.position, 3)


func _spawn(team: Unit.Team, pos: Vector2, count: int) -> void:
	for i in count:
		var unit := UNIT_SCENE.instantiate()
		unit.team = team
		unit.position = pos + Vector2(i * 40, 0)
		add_child(unit)
