class_name SnareDrumTurret
extends TurretType

func _setup_projectile_instance(direction: Vector2) -> DrumBeat:
	var projectile: DrumBeat = projectile_scene.instantiate()
	projectile.direction = direction
	projectile.speed = 350
	projectile.pierces_remaining = 1
	return projectile
