extends Unit

const PROJECTILE_SCENE := preload("res://units/projectile.tscn")


func _attack(_enemy: Unit) -> void:
	var projectile := PROJECTILE_SCENE.instantiate()
	projectile.team = team
	projectile.damage = data.damage
	# start the projectile slightly in front of the unit
	var facing := 1 if team == Team.PLAYER else -1
	projectile.position = position + Vector2(facing * 20, 0)
	# parent the projectile to the Lane
	get_parent().add_child(projectile)
