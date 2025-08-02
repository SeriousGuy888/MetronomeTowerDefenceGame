class_name Projectile extends Area2D

@export var sprite: Sprite2D

var damage: int = 1
var damage_type: Enums.TurretDamageType = Enums.TurretDamageType.PERCUSSION

func set_damage_info(new_damage: int, new_damage_type: Enums.TurretDamageType):
	damage = new_damage
	damage_type = new_damage_type

func _process(_delta) -> void:
	delete_if_far_away()

func delete_if_far_away():
	# temporary way to delete bullets once they're far away
	if abs(position.x) > 2000 or abs(position.y) > 2000:
		queue_free()

func _on_area_entered(area):
	if area is Enemy:
		area.take_damage(damage, damage_type)
		queue_free()
