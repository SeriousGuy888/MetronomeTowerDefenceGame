class_name TomDrumTurret
extends TurretType

func _setup_projectile_instance(direction: Vector2) -> DrumBeat:
	var projectile: DrumBeat = projectile_scene.instantiate()
	projectile.direction = direction
	projectile.speed = 250
	projectile.pierces_remaining = 0
	return projectile
