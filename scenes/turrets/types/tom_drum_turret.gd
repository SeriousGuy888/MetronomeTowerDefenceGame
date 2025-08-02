class_name TomDrumTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> DrumBeat:
	var projectile: DrumBeat = projectile_scene.instantiate()
	projectile.direction = Vector2.from_angle(deg_to_rad(lane))
	projectile.speed = 250
	projectile.pierces_remaining = 0
	return projectile
