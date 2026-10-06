extends Node2D


func spawn(team: Unit.Team, data: UnitData) -> void:
	var marker := ($PlayerSpawn if team == Unit.Team.PLAYER else $EnemySpawn) as Marker2D
	var unit := data.scene.instantiate() as Unit
	unit.data = data
	unit.position = marker.position
	unit.team = team
	add_child(unit)
