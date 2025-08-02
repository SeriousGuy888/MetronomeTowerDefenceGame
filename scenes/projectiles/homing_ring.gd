class_name HomingRing extends Projectile

@export var targeted_enemy: Enemy = null

var direction: Vector2:
	get: return direction
	set(value): direction = value.normalized()

var tick = 0

func _process(delta) -> void:
	super(delta)
	if targeted_enemy:
		direction = targeted_enemy.global_position - global_position
	elif tick % 20 == 0:
		var enemies = PlaythroughManager.get_tree().get_nodes_in_group("enemies")
		if !enemies.is_empty():
			targeted_enemy = enemies.pick_random()
	
	position += direction * 250 * delta
	tick += 1
