extends Control

@onready var Exit_Button: Button = $MarginContainer/VBoxContainer/Exit_Button as Button

signal exit_option_menu

func _ready() -> void:
	Exit_Button.button_down.connect(on_exit_pressed)
	set_process(false)
func on_exit_pressed():
	exit_option_menu.emit()
	set_process(false)
