extends Node

const Flare = preload("res://Assets/Effects/Flare.tscn")
const Explosion = preload("res://Assets/Effects/Explosion.tscn")
const PowerUp = preload("res://Assets/Items/PowerUp.tscn")

onready var hit_ship_sound = $HitShip
onready var hit_enemy_sound = $HitEnemy
onready var power_up_sound = $PowerUp

var camera
var flash
var main_scene

func camera_shake(magnitude, duration):
	if camera:
		camera.shake(magnitude, duration)

func screen_flash():
	if flash:
		flash.play()

func spawn_flare(position):
	if main_scene:
		var flare = Flare.instance()
		flare.global_position = position
		main_scene.add_child(flare)

func spawn_explosion(position):
	if main_scene:
		var explosion = Explosion.instance()
		explosion.global_position = position
		main_scene.add_child(explosion)

func spawn_power_up(position):
	if main_scene:
		var power_up = PowerUp.instance()
		power_up.global_position = position
		main_scene.add_child(power_up)
