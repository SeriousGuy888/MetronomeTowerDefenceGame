class_name SnareDrumTurret
extends TurretType

func _setup_projectile_instance(lane: Enums.Lane) -> DrumBeat:
	var projectile: DrumBeat = projectile_scene.instantiate()
	projectile.direction = Vector2.from_angle(deg_to_rad(lane))
	projectile.speed = 350
	projectile.pierces_remaining = 1
	return projectile
