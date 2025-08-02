class_name HomingRing extends Projectile

@export var targeted_enemy: Enemy = null

var lane: Enums.Lane

var direction: Vector2:
	get: return direction
	set(value): direction = value.normalized()

var tick = 0

func _ready() -> void:
	direction = Vector2.from_angle(deg_to_rad(lane))

func _process(delta) -> void:
	super(delta)
	if targeted_enemy:
		direction = targeted_enemy.global_position - global_position
	elif tick % 20 == 0:
		var enemies = PlaythroughManager.get_tree().get_nodes_in_group("enemies")
		if !enemies.is_empty():
			var enemies_in_own_lane = enemies.filter(func(enemy: Enemy): return enemy.lane == lane)
			if !enemies_in_own_lane.is_empty():
				targeted_enemy = enemies_in_own_lane.pick_random()
			else:
				targeted_enemy = enemies.pick_random()
	
	position += direction * 250 * delta
	tick += 1
