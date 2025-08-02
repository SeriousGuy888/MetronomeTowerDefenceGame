class_name DrumBeat extends Projectile

@export var speed = 250
@export var pierces_remaining = 0

var direction: Vector2:
	get: return direction
	set(value): direction = value.normalized()

func _process(delta) -> void:
	position += direction * speed * delta
	look_at(position + direction)
	# temporary way to delete bullets once they're far away
	if abs(position.x) > 2000 or abs(position.y) > 2000:
		queue_free()

func _on_area_entered(area):
	if area is Enemy:
		area.take_damage(1)
		pierces_remaining -= 1
		if pierces_remaining < 0:
			queue_free()
