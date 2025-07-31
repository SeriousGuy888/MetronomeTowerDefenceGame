extends Node2D

var turret: Turret = null

func place_turret(new_turret_scene: PackedScene):
	remove_turret()
	
	turret = new_turret_scene.instantiate()
	add_child(turret)
	
func remove_turret():
	if turret:
		turret.queue_free()
		turret = null
