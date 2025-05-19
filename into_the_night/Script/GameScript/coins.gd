extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.coins +=1
		print(global.coins)
	queue_free()
