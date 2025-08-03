class_name TriangleTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> HomingRing:
	var projectile: HomingRing = projectile_scene.instantiate()
	projectile.lane = lane
	
	return projectile
