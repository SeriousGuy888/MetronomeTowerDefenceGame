class_name TriangleTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> HomingRing:
	var projectile: HomingRing = projectile_scene.instantiate()
	projectile.direction = Vector2.from_angle(deg_to_rad(lane))
	projectile.damage = 0.25
	
	return projectile
