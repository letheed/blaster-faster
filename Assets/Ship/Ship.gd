extends "res://Assets/Character/Character.gd"

onready var target_x = rect.end.x / 2
onready var canon_left = $LaserCanonLeft
onready var canon_right = $LaserCanonRight
onready var canon_timer = $CanonTimer
onready var invulnerability_timer = $InvulnerabilityTimer

var double_laser = false setget set_double_laser
var invulnerable = false

func _notification(what):
	if what == NOTIFICATION_UNPAUSED:
		_unpaused()

func _process(delta):
	global_position.x += (target_x - global_position.x) * 0.2

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		target_x = clamp(get_global_mouse_position().x, x_min, x_max)

func _unpaused():
	var mouse_position = get_global_mouse_position()
	mouse_position.x = global_position.x
	mouse_position = get_viewport_transform() * mouse_position
	Input.warp_mouse_position(mouse_position)

func set_hp(new_hp):
	if invulnerable and new_hp < hp:
		pass
	else:
		.set_hp(new_hp)

func set_double_laser(state):
	double_laser = state
	canon_left.double_laser = double_laser
	canon_right.double_laser = double_laser
	if double_laser:
		canon_timer.start()
	else:
		canon_timer.stop()

func disable_double_laser():
	self.double_laser = false

func disable_invulnerability():
	invulnerable = false
	anim.stop()
	anim.seek(0, true)

func on_hit():
	invulnerable = true
	anim.play("Blinking")
	invulnerability_timer.start()
	Effects.hit_ship_sound.play()
	Effects.screen_flash()
	Effects.camera_shake(6, 0.4)

func on_died():
	Effects.spawn_explosion(global_position)
	Effects.hit_ship_sound.play()
	Effects.screen_flash()
	Effects.camera_shake(12, 1)
	var tree = get_tree()
	var position1 = global_position + Vector2(rand_range(-30, 30), rand_range(-30, 30))
	var position2 = global_position + Vector2(rand_range(-30, 30), rand_range(-30, 30))
	tree.create_timer(0.2).connect("timeout", Effects, "spawn_explosion", [position1])
	tree.create_timer(0.4).connect("timeout", Effects, "spawn_explosion", [position2])
