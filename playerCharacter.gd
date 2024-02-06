extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var coyote = 5
@export var jumpMaxLength = 3
var isJumpheld = false
var hasJumped = false
var coyoteTimer = 0

@onready var animate = %maskungabunga

func _ready():
	animate.play("Idle")
func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	if direction:
		animate.play("Run")
		if direction < 0:
			animate.flip_h = true
		else:
			animate.flip_h = false
		velocity.x = direction * SPEED
	else:
		animate.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Add the gravity.
	if not is_on_floor():
		coyoteTimer += delta
		if velocity.y < 0:
			velocity.y += gravity * delta
			animate.play("Jump")
		else:
			velocity.y += gravity *delta * 1.5
			animate.play("fall")
	else:
		coyoteTimer = 0
		hasJumped = false
		isJumpheld = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (coyoteTimer <= coyote) and not hasJumped:
		velocity.y = JUMP_VELOCITY
		hasJumped = true
		isJumpheld = true

	if Input.is_action_just_released("jump") and isJumpheld:
		velocity.y = maxf(velocity.y, -25)
		isJumpheld = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	move_and_slide()
