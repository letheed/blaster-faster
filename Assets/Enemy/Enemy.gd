extends "res://Assets/Character/Character.gd"

export(Vector2) var velocity

func _ready():
	if randf() < 0.5:
		velocity.x *= -1

func _process(delta):
	global_position += velocity * delta
	if velocity.x != 0:
		walls_rebound()

func walls_rebound():
	if x_max <= global_position.x:
		global_position.x -= global_position.x - x_max
		velocity.x *= -1
	elif global_position.x < x_min:
		global_position.x += x_min - global_position.x
		velocity.x *= -1

func on_area_entered(object):
	if object.is_in_group("Player"):
		object.hp -= 1
		self.hp = 0

func on_hit():
	anim.play("Blink")
	Effects.hit_enemy_sound.play()

func on_died():
	Effects.spawn_explosion(global_position)
	Effects.camera_shake(2, 0.4)
	Game.score += 5
	if randf() < 0.1:
		Effects.spawn_power_up(global_position)

func on_player_died():
	if velocity.x != 0:
		velocity = Vector2(0, velocity.length())
	if velocity.y > 100:
		velocity.y = 100
	velocity.y += rand_range(-10, 10)
	if $LaserCanonEnemy:
		$LaserCanonEnemy.timer.stop()
