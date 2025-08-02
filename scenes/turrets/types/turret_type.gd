class_name TurretType
extends Resource

@export var projectile_scene: PackedScene
@export var damage_type: Enums.TurretDamageType = Enums.TurretDamageType.PERCUSSION
@export var base_damage: int = 1

@export var texture: Texture2D
@export var name: String = "Unnamed Turret"
@export var price: int = 1
@export var upgrades_to: Array[TurretType]

func create_projectile_instance(direction: Vector2) -> Projectile:
	if projectile_scene:
		return _setup_projectile_instance(direction)
	return null

func _setup_projectile_instance(_direction: Vector2) -> Projectile:
	push_warning("Base TurretType projectile spawning behaviour called.
		No effects were applied to projectile.")
	var projectile = projectile_scene.instantiate()
	if projectile.has_method("set_damage_info"):
		projectile.set_damage_info(base_damage, damage_type)
	return projectile
