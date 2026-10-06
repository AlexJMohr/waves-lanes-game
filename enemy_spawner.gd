extends Node

@export var lane: Node
@export var spawn_interval: float = 0.4


func _ready() -> void:
	var level := Levels.LEVELS[0]
	for wave in level:
		await get_tree().create_timer(wave.delay).timeout
		for data in wave.units:
			lane.spawn(Unit.Team.ENEMY, data)
			await get_tree().create_timer(spawn_interval).timeout
