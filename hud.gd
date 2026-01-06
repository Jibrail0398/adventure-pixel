extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var pause_menu: Control = $PauseMenu
@onready var game_over_screen: Control = $GameOverScreen

func _ready()->void:
	pause_menu.visible = false
	game_over_screen.visible = false


func update_score_text(score_baru):
	score_label.text = "Score: " + str(score_baru)
	
func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()


func toggle_pause():
	
	var is_paused = get_tree().paused
	
	
	get_tree().paused = not is_paused
	
	
	pause_menu.visible = not is_paused
	
func _on_start_pressed() -> void:
	toggle_pause()
	
func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scene/screen_title.tscn")

func show_game_over():
	game_over_screen.visible = true
	
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	
	get_tree().paused = false
	get_tree().reload_current_scene()
