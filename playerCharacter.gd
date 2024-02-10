extends CharacterBody2D
class_name Player



const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var voidout = 700
@export var coyote = 0.05
var isJumpheld = false
var hasJumped = false
var coyoteTimer = 0
var respawnPoint = Vector2()

var moveTarget = 0
var wallJump = false

@onready var animate = %maskungabunga

func _ready():
	animate.play("Idle")
	respawnPoint = global_position
	


func _physics_process(delta):
	if global_position.y >= voidout:
		die()
		
	var direction = Input.get_axis("left", "right")
	if direction:
		animate.play("Run")
		if direction < 0:
			animate.flip_h = true
		else:
			animate.flip_h = false
		moveTarget = direction * SPEED
		if is_on_wall_only():
			wallJump = true
	else:
		animate.play("Idle")
		moveTarget = 0
	
	if not is_on_wall_only():
		wallJump = false
	# Add the gravity.
	if not is_on_floor():
		coyoteTimer += delta
		if velocity.y < 0:
			velocity.y += gravity * delta
			animate.play("Jump")
		else:
			if wallJump:
				velocity.y += gravity *delta * .75
			else:
				velocity.y += gravity *delta * 1.5
			animate.play("fall")
		
		velocity.x = move_toward(velocity.x, moveTarget, SPEED/20)
	else:
		velocity.x = move_toward(velocity.x, moveTarget, SPEED/10)
		coyoteTimer = 0
		hasJumped = false
		isJumpheld = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (coyoteTimer <= coyote) and not hasJumped:
		if wallJump:
			if animate.flip_h:
				velocity.x = -JUMP_VELOCITY
			else:
				velocity.x = JUMP_VELOCITY
		velocity.y = JUMP_VELOCITY
		hasJumped = true
		isJumpheld = true

	if Input.is_action_just_released("jump") and isJumpheld:
		velocity.y = maxf(velocity.y, -100)
		isJumpheld = false
		
	if wallJump:
		coyoteTimer = 0
		animate.play("wall")
		hasJumped = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	move_and_slide()

func die():
	global_position = respawnPoint
	velocity = Vector2.ZERO
