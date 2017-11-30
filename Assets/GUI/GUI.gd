extends Control

enum MenuType {MENU_NONE, MENU_PAUSE, MENU_GAMEOVER}

const Menu = preload("res://Game/Menu.tscn")

var menu_type = MENU_NONE setget set_menu_type

func _ready():
	for menu in get_children():
		menu.visible = false
	update_mouse_mode()

func _unhandled_input(event):
	if event.is_action_pressed("ui_menu"):
		match menu_type:
			MENU_NONE:
				get_tree().set_pause(true)
				self.menu_type = MENU_PAUSE
			MENU_PAUSE:
				on_pressed_continue()
			MENU_GAMEOVER:
				pass

func set_menu_type(new_menu_type):
	if new_menu_type != menu_type:
		set_menu_visibility(false)
		menu_type = new_menu_type
		set_menu_visibility(true)
		update_mouse_mode()

func set_menu_visibility(value):
	match menu_type:
		MENU_NONE: pass
		MENU_PAUSE: $Pause.visible = value
		MENU_GAMEOVER: $GameOver.visible = value

func update_mouse_mode():
	if OS.has_feature("web"):
		return
	match menu_type:
		MENU_NONE: Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		_: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func on_pressed_menu():
	get_tree().set_pause(false)
	get_tree().change_scene_to(Menu)

func on_pressed_continue():
	self.menu_type = MENU_NONE
	get_tree().set_pause(false)
