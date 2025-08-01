class_name Bullet extends Area2D

@onready var sprite: Sprite2D = $sprite

var direction: Vector2:
	get:
		return direction
	set(value):
		direction = value.normalized()

func _ready() -> void:
	pass

func _process(delta) -> void:
	position += direction * 250 * delta
	look_at(position + direction)
	# temporary way to delete bullets once they're far away
	if abs(position.x) > 2000 or abs(position.y) > 2000:
		queue_free()

func _on_area_entered(area):
	if area is Enemy:
		print("aa")
		area.take_damage(1)
		queue_free()
