extends Area2D

@onready var timer: Timer = $Timer
@onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	animation_player.play("die")
	#print("YOU DIE!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	var hud = get_tree().get_first_node_in_group("HUD_GROUP")
	if hud:
		hud.show_game_over()
	else:
		print("Error: Node HUD tidak ditemukan di dalam grup!")
	
	
