class_name Enemy extends Area2D

@export var speed = 50.0
@export var health = 1
@export var coins_dropped = 3
@export var member_of_wave: int = -1

func _ready():
	$HealthBar.max_value=health
	$HealthBar.visible=false
	set_health_bar()

func set_health_bar()->void:
	$HealthBar.value = health
	if health < $HealthBar.max_value:
		$HealthBar.visible=true

func _process(delta):
	var direction_to_center = global_position.direction_to(Vector2.ZERO)
	position += direction_to_center * speed * delta

func take_damage(damage_amount):
	health -= damage_amount
	set_health_bar()
	if health <= 0:
		die(true)

func die(was_killed: bool):
	if was_killed:
		EventBus.request_add_coins.emit(coins_dropped)
	if member_of_wave != null:
		EventBus.enemy_from_wave_died.emit(member_of_wave)
	queue_free()
