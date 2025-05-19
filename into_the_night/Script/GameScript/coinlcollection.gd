extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	$Label.text = str(global.coins)
func _pass():
	pass
