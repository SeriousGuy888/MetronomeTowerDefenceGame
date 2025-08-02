class_name Enemy extends Area2D

@export var enemy_type: EnemyType
@export var member_of_wave: int = -1
@export var lane: Enums.Lane = Enums.Lane.RIGHT

var health: int
var max_health: int
var speed: float
var coins_dropped: int

func _ready():
	# Initialize with default values first
	max_health = 10
	health = 10
	speed = 50.0
	coins_dropped = 3
	
	if !enemy_type:
		push_warning(self.name + " has no enemy type defined. Using default values.")
	else:
		# Initialize stats from enemy type
		max_health = enemy_type.base_health
		health = max_health
		speed = enemy_type.base_speed
		coins_dropped = enemy_type.coins_dropped
		
		# Set sprite texture and visual properties
		if enemy_type.texture:
			$Sprite2D.texture = enemy_type.texture
		
		# Apply visual customization based on enemy type
		apply_visual_style()
	
	# Setup health bar
	$HealthBar.max_value = max_health
	$HealthBar.visible = false
	set_health_bar()

func apply_visual_style():
	if !enemy_type:
		return
		
	# Apply different visual styles based on enemy type
	match enemy_type.enemy_type:
		Enums.EnemyType.BASIC:
			$Sprite2D.modulate = Color.WHITE
			$Sprite2D.scale = Vector2(0.2, 0.2)
			$CollisionShape2D.shape.size = Vector2(30, 42)
			
		Enums.EnemyType.FAST:
			$Sprite2D.modulate = Color(1, 0.8, 0.8, 1) # Light red tint
			$Sprite2D.scale = Vector2(0.15, 0.15) # Smaller
			$CollisionShape2D.shape.size = Vector2(25, 35)
			
		Enums.EnemyType.TANK:
			$Sprite2D.modulate = Color(0.6, 0.8, 0.6, 1) # Green tint
			$Sprite2D.scale = Vector2(0.3, 0.3) # Larger
			$CollisionShape2D.shape.size = Vector2(40, 50)
			
		Enums.EnemyType.ARMORED:
			$Sprite2D.modulate = Color(0.7, 0.7, 1, 1) # Blue tint
			$Sprite2D.scale = Vector2(0.22, 0.22)
			$CollisionShape2D.shape.size = Vector2(32, 44)
			
		Enums.EnemyType.FLYING:
			$Sprite2D.modulate = Color(1, 1, 0.6, 1) # Yellow tint
			$Sprite2D.scale = Vector2(0.18, 0.18)
			$CollisionShape2D.shape.size = Vector2(28, 38)
			
		Enums.EnemyType.BOSS:
			$Sprite2D.modulate = Color(1, 0.3, 0.3, 1) # Red tint
			$Sprite2D.scale = Vector2(0.4, 0.4) # Much larger
			$CollisionShape2D.shape.size = Vector2(60, 80)
	
	# Adjust health bar size based on enemy size
	var health_bar_width = $CollisionShape2D.shape.size.x * 0.8
	$HealthBar.position.x = - health_bar_width / 2
	$HealthBar.size.x = health_bar_width
	$HealthBar.position.y = $CollisionShape2D.shape.size.y / 2 + 5

func set_health_bar() -> void:
	$HealthBar.value = health
	if health < max_health:
		$HealthBar.visible = true

func _process(delta):
	var direction_to_center = global_position.direction_to(Vector2.ZERO)
	position += direction_to_center * speed * delta

func take_damage(base_damage: int, turret_damage_type: Enums.TurretDamageType = Enums.TurretDamageType.PERCUSSION):
	if !enemy_type:
		health -= base_damage
	else:
		var damage_multiplier = enemy_type.get_damage_multiplier(turret_damage_type)
		var actual_damage = int(base_damage * damage_multiplier)
		health -= actual_damage
	
	set_health_bar()
	if health <= 0:
		die(true)

func die(was_killed: bool):
	if was_killed:
		EventBus.request_add_coins.emit(coins_dropped)
	if member_of_wave != null:
		EventBus.enemy_from_wave_died.emit(member_of_wave)
	queue_free()
