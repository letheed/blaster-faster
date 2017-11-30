extends Position2D

export(PackedScene) var Laser

onready var main_scene = get_tree().get_current_scene()
onready var flare = $Flare
onready var timer = $Timer
onready var laser_sound = $AudioStreamPlayer

var double_laser = false

func shoot():
	flare.play()
	laser_sound.play()
	if double_laser:
		var laser1 = Laser.instance()
		var laser2 = Laser.instance()
		laser1.global_position = global_position
		laser2.global_position = global_position
		laser1.velocity.x = 15
		laser2.velocity.x = -15
		main_scene.add_child(laser1)
		main_scene.add_child(laser2)
	else:
		var laser = Laser.instance()
		laser.global_position = global_position
		main_scene.add_child(laser)