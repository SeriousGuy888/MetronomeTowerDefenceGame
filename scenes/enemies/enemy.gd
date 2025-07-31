extends Area2D

@export var speed = 50.0

func _process(delta):
	var direction_to_center = global_position.direction_to(Vector2.ZERO)
	position += direction_to_center * speed * delta

func take_damage():
	queue_free()
