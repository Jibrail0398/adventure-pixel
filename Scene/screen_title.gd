extends Control

# Fungsi ini dipanggil otomatis saat tombol Start ditekan
func _on_button_pressed() -> void:
	# Ganti path di bawah ini sesuai dengan lokasi level 1 Anda
	# Berdasarkan level_manager Anda, kemungkinan besar path-nya seperti ini:
	var path_level_1 = "res://Level/Level_1.tscn"
	
	# Cek apakah file level 1 benar-benar ada agar tidak error/crash
	if ResourceLoader.exists(path_level_1):
		get_tree().change_scene_to_file(path_level_1)
	else:
		print("Error: Level 1 tidak ditemukan di path: ", path_level_1)
		# Jika nama file Anda beda, ganti path di atas, misal: "res://game.tscn"
