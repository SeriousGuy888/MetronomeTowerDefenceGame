class_name TriangleTurret
extends TurretType

func _setup_projectile_instance(direction: Vector2) -> HomingRing:
	var projectile: HomingRing = projectile_scene.instantiate()
	projectile.direction = direction
	projectile.damage = 0.25
	
	return projectile
