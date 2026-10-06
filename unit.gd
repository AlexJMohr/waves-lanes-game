class_name Unit
extends CharacterBody2D

enum Team {
	PLAYER,
	ENEMY,
}

@export var team: Team = Team.PLAYER
@export var max_health: int = 50
@export var damage: int = 10
@export var speed: float = 100.0
@export var attack_range: float = 30.0
@export var attack_cooldown: float = 1.0
@export var cost: int = 5

var health: int = max_health
var attack_accumulator: float = attack_cooldown

const PLAYER_LAYER := 1
const ENEMY_LAYER := 2


func _ready() -> void:
	add_to_group("player_units" if team == Team.PLAYER else "enemy_units")
	$HealthBar.max_health = max_health
	$HealthBar.health = health
	collision_layer = PLAYER_LAYER if team == Team.PLAYER else ENEMY_LAYER
	collision_mask = PLAYER_LAYER | ENEMY_LAYER


func _physics_process(delta: float) -> void:
	attack_accumulator += delta

	var enemy := _get_nearest_enemy()
	if enemy != null and global_position.distance_to(enemy.global_position) < attack_range:
		velocity = Vector2.ZERO
		if attack_accumulator >= attack_cooldown:
			_attack(enemy)
			attack_accumulator = 0
	else:
		var direction := 1 if team == Team.PLAYER else -1
		velocity = Vector2(direction * speed, 0)
	move_and_slide()


func _attack(enemy: Unit) -> void:
	enemy.take_damage(damage)


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
		queue_free()
