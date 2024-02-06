extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var coyote = 5
var hasJumped = false
var coyoteTimer = 0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		coyoteTimer += delta
		if velocity.y < 0:
			velocity.y += gravity * delta
		else:
			velocity.y += gravity *delta * 1.5
	else:
		coyoteTimer = 0
		hasJumped = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (coyoteTimer <= coyote) and not hasJumped:
		velocity.y = JUMP_VELOCITY
		hasJumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
