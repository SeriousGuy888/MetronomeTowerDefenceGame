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
const DRUM_TURRET = preload("res://scenes/drum_turret.tscn")
func _ready():
	place_turret(DRUM_TURRET)

func place_turret(new_turret_scene: PackedScene):
	remove_turret()
	
	turret = new_turret_scene.instantiate()
	add_child(turret)
	
func remove_turret():
	if turret:
		turret.queue_free()
		turret = null

func fire():
	if turret:
		turret.fire(direction)
