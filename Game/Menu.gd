extends Control

const Stage1 = preload("res://Stages/Stage 1.tscn")

func _ready():
	set_highscore(Game.highscore)
	if not Game.soundtrack.playing:
		Game.soundtrack.play()

func set_highscore(new_highscore):
	$Highscore.set_score(new_highscore)

func on_pressed_start():
	get_tree().change_scene_to(Stage1)

func on_pressed_quit():
	Game.quit()
