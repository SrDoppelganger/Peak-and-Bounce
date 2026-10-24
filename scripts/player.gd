extends CharacterBody2D

const GRAVITY = 1000.0
const SPEED = 300.0
const ACCELERATION = 100.0
const JUMP_VELOCITY = -450.0
const FALL_GRAVITY = 2000.0


func get_jump_gravity(velocity:Vector2):
	if velocity.y < 0:
		return GRAVITY
	return FALL_GRAVITY
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_jump_gravity(velocity) * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("JUMP") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4 #implementa shorthop
	
	if Input.is_action_just_pressed("BOUNCE") and !is_on_floor():
		velocity.y = -JUMP_VELOCITY * ACCELERATION * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
