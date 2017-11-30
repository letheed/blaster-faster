extends Node2D

export(bool) var enabled = true setget set_enabled
export(PackedScene) var Enemy
export(float, 0.1, 10) var timer_min = 0.5
export(float, 0.1, 10) var timer_max = 1.5

onready var timer = $Timer

func _ready():
	random_wait()

func set_enabled(state):
	var was_enabled = enabled
	enabled = state
	if enabled and not was_enabled:
		random_wait()
	elif not enabled and was_enabled:
		timer.stop()

func random_wait():
	timer.wait_time = rand_range(timer_min, timer_max)
	timer.start()

func spawn_enemy():
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.global_position.x = rand_range(enemy.x_min, enemy.x_max)
	random_wait()
