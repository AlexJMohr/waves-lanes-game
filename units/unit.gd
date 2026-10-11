class_name Unit
extends CharacterBody2D

enum Team {
	PLAYER,
	ENEMY,
}

@onready var agent = $NavigationAgent2D
@export var team: Team = Team.PLAYER
var data: UnitData
var health: int
var attack_accumulator: float

const PLAYER_LAYER := 1
const ENEMY_LAYER := 2


func _ready() -> void:
	health = data.max_health
	attack_accumulator = data.attack_cooldown
	add_to_group("player_units" if team == Team.PLAYER else "enemy_units")
	collision_layer = PLAYER_LAYER if team == Team.PLAYER else ENEMY_LAYER
	collision_mask = PLAYER_LAYER | ENEMY_LAYER
	$HealthBar.max_health = data.max_health
	$HealthBar.health = health
	agent.velocity_computed.connect(_on_velocity_computed)
	agent.max_speed = data.speed


func _physics_process(delta: float) -> void:
	attack_accumulator += delta

	var enemy := _get_nearest_enemy()

	if enemy != null and global_position.distance_to(enemy.global_position) < data.attack_range:
		# enemy in range -> stop and attack
		agent.set_velocity(Vector2.ZERO)
		# avoid nobody -> nobody can shove us
		agent.avoidance_mask = 0
		if attack_accumulator >= data.attack_cooldown:
			_attack(enemy)
			attack_accumulator = 0
	else:
		# moving: avoid same-team units only
		agent.avoidance_mask = 1 << (0 if team == Team.PLAYER else 1)
		if enemy == null:
			# no enemy -> move horizontally
			var direction := 1 if team == Team.PLAYER else -1
			agent.target_position = Vector2(direction * 10000, global_position.y)
		else:
			# enemy out of range -> move towards it
			agent.target_position = enemy.global_position
		agent.set_velocity(
			(agent.get_next_path_position() - global_position).normalized() * data.speed
		)


func _on_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()


func _attack(enemy: Unit) -> void:
	enemy.take_damage(data.damage)


func _get_nearest_enemy() -> Unit:
	var units = _get_opposing_units()
	var nearest: Unit = null
	var nearest_dist: float = INF
	for u in units:
		var dist: float = global_position.distance_to(u.global_position)
		if nearest_dist > dist:
			nearest = u as Unit
			nearest_dist = dist
	return nearest


func _get_opposing_units():
	return get_tree().get_nodes_in_group("enemy_units" if team == Team.PLAYER else "player_units")


func take_damage(amount: int):
	health -= amount
	$HealthBar.health = health
	if health <= 0:
		if team == Team.ENEMY:
			GameState.add_money(int(data.cost * GameState.KILL_REWARD_FRACTION))
		queue_free()
