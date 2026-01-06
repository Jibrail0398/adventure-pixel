extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ROLL_SPEED = 180.0  # Speed during rolling
const ROLL_DURATION = 0.5  # Duration of the roll in seconds

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = %GameManager
@onready var animation_player = $AnimationPlayer

var is_rolling = false
var roll_timer = 0.0

func _physics_process(delta: float) -> void:
	# Add gravity if not on the floor.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")
		
	# Trigger rolling animation when the "rolling" action is pressed
	if Input.is_action_just_pressed("rolling") and is_on_floor() and not is_rolling:
		start_rolling()

	# Rolling timer countdown if rolling
	if is_rolling:
		roll_timer -= delta
		if roll_timer <= 0:
			stop_rolling()

	# GET Input Direction
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite based on direction
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Handle animations when on the floor
	if is_on_floor():
		if direction == 0 and not is_rolling:
			animated_sprite_2d.play("idle")
		elif not is_rolling:
			animated_sprite_2d.play("run")
		velocity.x = direction * SPEED
	else:
		# Handle jump animation in the air
		animated_sprite_2d.play("jump")
		
		# Apply horizontal movement in the air
		velocity.x = direction * SPEED  # Maintain control over horizontal movement in the air

	# Handle rolling animation
	if is_rolling:
		animated_sprite_2d.play("rolling")
		velocity.x = direction * ROLL_SPEED  # Apply roll speed while rolling

	# Apply movement
	move_and_slide()

# Function to start rolling
func start_rolling():
	is_rolling = true
	roll_timer = ROLL_DURATION  # Set timer for rolling duration
	animated_sprite_2d.play("rolling")

# Function to stop rolling
func stop_rolling():
	is_rolling = false
	# Return to run or idle animation after rolling
	if Input.get_axis("move_left", "move_right") != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
