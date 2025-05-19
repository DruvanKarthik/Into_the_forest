extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button
@onready var Exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button
@onready var options_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button

@onready var options_menu: Control = $Options_Menu 
@onready var margin_container: MarginContainer = $MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_connecting_signals()

func on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game_secenes/Levels/Level_1.tscn")
func on_exit_pressed():
	get_tree().quit()
func on_options_pressed():
	margin_container.visible = false
	options_menu.visible = true
func on_exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false
func handle_connecting_signals():
	start_button.button_down.connect(on_start_pressed)
	options_button.button_down.connect(on_options_pressed)
	Exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_option_menu.connect(on_exit_options_menu)
