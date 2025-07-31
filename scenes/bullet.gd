class_name Bullet extends RigidBody2D

@onready var sprite: Sprite2D = $sprite

var _direction: Vector2
var direction: Vector2:
	get:
		return _direction
	set(value):
		_direction = value.normalized()

func _ready() -> void:
	pass

func _process(delta) -> void:
	translate(direction * 250 * delta)
	look_at(direction)
	# temporary way to delete bullets once they're far away
	if abs(position.x) > 2000 || abs(position.y) > 2000:
		queue_free()
