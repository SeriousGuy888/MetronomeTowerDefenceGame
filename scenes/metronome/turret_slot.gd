class_name TurretSlot extends Node2D

const TURRET_SCENE = preload("res://scenes/turrets/turret.tscn")
const NO_TURRET = preload("res://resources/turrets/no_turret.tres")

var turret: Turret = null:
	get: return turret
	set(new_value):
		turret = new_value
		EventBus.turret_slot_turret_updated.emit(self)

# How this slot is oriented in relation to the center of the metronome.
# Also determines which way its projectiles will fire.
var direction: Vector2:
	get:
		return direction
	set(value):
		direction = value.normalized()

func _ready():
	place_turret(TURRET_SCENE, NO_TURRET)
	pass

func place_turret(new_turret_scene: PackedScene, turret_type: TurretType):
	_remove_turret()
	
	var new_turret = new_turret_scene.instantiate()
	new_turret.turret_type = turret_type
	turret = new_turret
	add_child(turret)
	
func _remove_turret():
	if turret:
		turret.queue_free()
		turret = null

func fire():
	if turret:
		turret.fire(direction)


func _on_texture_button_button_up() -> void:
	EventBus.request_select_turret_slot.emit(self)
