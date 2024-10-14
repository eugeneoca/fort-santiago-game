extends CharacterBody3D

const STAND_SPEED = 5
var SPEED = 5.0
const JUMP_VELOCITY = 4.5

const CROUCH_SPEED = 1.0
var CROUCH_HEIGHT = 0.5

var look_dir: Vector2
@onready var head = $head
@onready var pointer = $head/RayCast3D
@onready var hud = $"../HUDCanvas/HUD"
@onready var journal = $"../HUDCanvas/Journal"

var mouse_sens = 0.2

func _physics_process(delta: float) -> void:
	var prompt = hud.get_node("PromptText")
	prompt.text = ""
	
	# Interaction
	if pointer.is_colliding():
		if pointer.get_collider().name == "testbox":
			prompt.text = "[E] Interact"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle crouch
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		head.global_position.y -= CROUCH_HEIGHT
		SPEED = CROUCH_SPEED
		
		
	if Input.is_action_just_released("crouch") and is_on_floor():
		head.global_position.y += CROUCH_HEIGHT
		SPEED = STAND_SPEED

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	
	# Mouse Motion
	if event is InputEventMouseMotion and !journal.visible:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
