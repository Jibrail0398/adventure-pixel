extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var pause_menu: Control = $PauseMenu

func _ready()->void:
	pause_menu.visible = false

#Untuk score
func update_score_text(score_baru):
	score_label.text = "Score: " + str(score_baru)
	
func _input(event: InputEvent) -> void:
	# "ui_cancel" secara default adalah tombol ESC di Godot
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

# Fungsi buatan sendiri untuk mengatur nyala/mati pause
func toggle_pause():
	# Cek status pause saat ini
	var is_paused = get_tree().paused
	
	# Balik kondisinya (kalau true jadi false, false jadi true)
	get_tree().paused = not is_paused
	
	# Tampilkan/Sembunyikan menu sesuai status pause
	pause_menu.visible = not is_paused
	
func _on_start_pressed() -> void:
	toggle_pause()
	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/screen_title.tscn")
