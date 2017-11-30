extends "res://Assets/Laser/LaserCanon.gd"

func _notification(what):
	if what == NOTIFICATION_UNPAUSED:
		_unpaused()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			shoot()
			timer.start()
		else:
			timer.stop()

func _unpaused():
	var timer_stopped = timer.is_stopped()
	if Input.get_mouse_button_mask() & BUTTON_LEFT:
		if timer_stopped:
			shoot()
			timer.start()
	else:
		if not timer_stopped:
			timer.stop()
