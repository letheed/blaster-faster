extends Node

const GUI = preload("res://Assets/GUI/GUI.gd")

func _enter_tree():
	Effects.main_scene = self

func _exit_tree():
	Effects.main_scene = null

func _ready():
	Game.score = 0
	if not Game.soundtrack.playing:
		Game.soundtrack.play()

func on_player_died():
	$CleverSpawner.enabled = false
	$KamikazeSpawner.enabled = false
	var tree = get_tree()
	tree.call_group("Enemies", "on_player_died")
	tree.create_timer(1).connect("timeout", $GUILayer/GUI, "set_menu_type", [GUI.MENU_GAMEOVER])
