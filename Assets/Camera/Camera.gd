extends Camera2D

var magnitude = 0
var duration = 0

func _exit_tree():
	Effects.camera = null

func _ready():
	set_process(false)
	Effects.camera = self

func _process(delta):
	var x = rand_range(-magnitude, magnitude)
	var y = rand_range(-magnitude, magnitude)
	position = Vector2(x, y)
	duration -= delta
	if duration < 0:
		reset()

func reset():
	set_process(false)
	position = Vector2(0, 0)
	magnitude = 0
	duration = 0

func shake(new_magnitude, new_duration):
	if magnitude <= new_magnitude:
		magnitude = new_magnitude
		duration = new_duration
		set_process(true)
