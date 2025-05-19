extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		var current_secen_file = get_tree().current_scene.scene_file_path
		var next_level = current_secen_file.to_int()+1
		
		var next_level_path = "res://Scenes/Game_secenes/Levels/Level_"+str(next_level)+".tscn"
		get_tree().change_scene_to_file(next_level_path)
