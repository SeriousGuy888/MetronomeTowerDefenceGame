class_name BassDrumTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> DrumBeat:
	var projectile: DrumBeat = projectile_scene.instantiate()
	projectile.direction = Vector2.from_angle(deg_to_rad(lane))
	projectile.speed = 100
	projectile.pierces_remaining = 999999
	return projectile
