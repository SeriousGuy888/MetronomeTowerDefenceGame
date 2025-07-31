extends Node2D

var turret: Turret = null

# How this slot is oriented in relation to the center of the metronome.
# Also determines which way its projectiles will fire.
var _direction: Vector2 = Vector2.UP
var direction: Vector2:
	get:
		return _direction
	set(value):
		_direction = value.normalized()

# temporary for testing
const TURRET_SCENE = preload("res://scenes/turrets/turret.tscn")
const DRUM_TURRET = preload("res://resources/guitar_turret.tres")
func _ready():
	place_turret(TURRET_SCENE, DRUM_TURRET)

func place_turret(new_turret_scene: PackedScene, turret_type: TurretType):
	remove_turret()
	
	turret = new_turret_scene.instantiate()
	turret.turret_type = turret_type
	add_child(turret)
	
func remove_turret():
	if turret:
		turret.queue_free()
		turret = null

func fire():
	if turret:
		turret.fire(direction)
