extends CharacterBody2D

# ===================== CONSTANTS =====================
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const ROLL_SPEED = 180.0
const ROLL_DURATION = 0.5

const DASH_SPEED = 350.0
const DASH_DURATION = 0.2

const MAX_JUMP = 2  # <<< DOUBLE JUMP

# ===================== NODES =====================
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# ===================== STATES =====================
var is_rolling = false
var roll_timer = 0.0

var is_dashing = false
var dash_timer = 0.0
var can_air_dash = true

var jump_count = 0  # <<< hitungan jump

# ===================== MAIN LOOP =====================
func _physics_process(delta: float) -> void:
	# Reset saat menyentuh tanah
	if is_on_floor():
		jump_count = 0
		can_air_dash = true

	# Gravity (mati saat dash)
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	# ===================== JUMP & DOUBLE JUMP =====================
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMP:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Roll di tanah
	if Input.is_action_just_pressed("rolling") and is_on_floor() and not is_rolling:
		start_rolling()

	# Dash di udara (Shift)
	if Input.is_action_just_pressed("dash") and not is_on_floor() and can_air_dash:
		start_air_dash()

	# Timer roll
	if is_rolling:
		roll_timer -= delta
		if roll_timer <= 0:
			stop_rolling()

	# Timer dash
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			stop_air_dash()

	# Input arah
	var direction := Input.get_axis("move_left", "move_right")

	# Flip sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true

	# ===================== ANIMATION =====================
	if is_dashing or is_rolling:
		animated_sprite_2d.play("rolling")
	elif is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	# ===================== MOVEMENT =====================
	if not is_dashing and not is_rolling:
		velocity.x = direction * SPEED

	if is_rolling:
		velocity.x = direction * ROLL_SPEED

	move_and_slide()

# ===================== ROLL =====================
func start_rolling():
	is_rolling = true
	roll_timer = ROLL_DURATION
	animated_sprite_2d.play("rolling")

func stop_rolling():
	is_rolling = false

# ===================== AIR DASH =====================
func start_air_dash():
	is_dashing = true
	dash_timer = DASH_DURATION
	can_air_dash = false
	velocity.y = 0

	var dir = Input.get_axis("move_left", "move_right")
	if dir == 0:
		dir = -1 if animated_sprite_2d.flip_h else 1

	velocity.x = dir * DASH_SPEED
	animated_sprite_2d.play("rolling")

func stop_air_dash():
	is_dashing = false
