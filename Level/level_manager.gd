extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		return

	var scene_path := get_tree().current_scene.scene_file_path
	var file_name := scene_path.get_file() # Level_1.tscn

	var level_number := file_name.replace("Level_", "").replace(".tscn", "").to_int()
	var next_level := level_number + 1

	var next_scene_path := "res://Level/Level_%d.tscn" % next_level

	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("Level terakhir atau file tidak ditemukan:", next_scene_path)
