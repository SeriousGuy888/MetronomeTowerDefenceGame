class_name TambourineTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> ShinyFrisbee:
	var projectile: ShinyFrisbee = projectile_scene.instantiate()
	projectile.lane = lane
	projectile.should_split = true
	return projectile
