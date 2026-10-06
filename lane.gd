extends Node2D

const UNIT_SCENE := preload("res://unit.tscn")
const RANGED_UNIT_SCENE := preload("res://ranged_unit.tscn")


# TEMPORARY: spawns test units. Delete this once the real buy/spawn flow exists.
func _ready() -> void:
	_spawn(RANGED_UNIT_SCENE, Unit.Team.PLAYER, $PlayerSpawn.position, 2, 0)
	_spawn(UNIT_SCENE, Unit.Team.PLAYER, $PlayerSpawn.position, 2, 2)
	_spawn(RANGED_UNIT_SCENE, Unit.Team.ENEMY, $EnemySpawn.position, 2, 0)
	_spawn(UNIT_SCENE, Unit.Team.ENEMY, $EnemySpawn.position, 2, 2)


func _spawn(scene: PackedScene, team: Unit.Team, pos: Vector2, count: int, start_index: int = 0) -> void:
	var facing := 1 if team == Unit.Team.PLAYER else -1
	for i in count:
		var unit := scene.instantiate()
		unit.team = team
		unit.position = pos + Vector2((start_index + i) * 40 * facing, 0)
		add_child(unit)
