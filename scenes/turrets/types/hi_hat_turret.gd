class_name HiHatTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> ShinyFrisbee:
	var projectile: ShinyFrisbee = projectile_scene.instantiate()
	projectile.lane = lane
	projectile.should_split = true
	projectile.should_split_into_neighbouring_lanes = true
	return projectile
