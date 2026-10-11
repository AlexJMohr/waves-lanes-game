extends Area2D

@export var speed: float = 250.0
@export var damage: int = 10
@export var max_distance: float = 1000.0
var direction: int = 1
@export var team: Unit.Team:
	set(val):
		team = val
		direction = 1 if team == Unit.Team.PLAYER else -1

var _distance_traveled: float = 0.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	collision_layer = 0
	collision_mask = Unit.ENEMY_LAYER if team == Unit.Team.PLAYER else Unit.PLAYER_LAYER


func _physics_process(delta: float) -> void:
	var step := speed * delta
	position.x += direction * step
	_distance_traveled += step
	if _distance_traveled >= max_distance:
		queue_free()


func _on_body_entered(body: Node2D):
	var unit := body as Unit
	if unit != null: # collision mask checks team
		unit.take_damage(damage)
		queue_free()
