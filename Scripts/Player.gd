extends CharacterBody3D

@onready var camera = $Camera
@export var SPEED = 5.0
@export var  JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	if not is_multiplayer_authority(): return
	camera.current = true


func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	
func _physics_process(delta):
	if not is_multiplayer_authority(): return
	move_wasd(delta)
	move_mouse()
	move_and_slide()
	
func move_mouse():
	if not is_multiplayer_authority(): return
	var mousePos = get_viewport().get_mouse_position()
	var middle: Vector2 = get_viewport().size / 2
	#Cooridnates start at top left, so we need to flip it, since up and left are negative, while down an right is positve:
	var mousePosNormalized = ((mousePos - middle) / middle).normalized()
	var direction = Vector3(mousePosNormalized.x, 0, mousePosNormalized.y)
#	print(direction)
#	if(Input.is_action_pressed("move_click")):
#		velocity.x = direction.x * SPEED
#		velocity.z = direction.z * SPEED
	$Pivot.look_at(position + direction, Vector3.UP)
	
	
func move_wasd(delta):
	if not is_multiplayer_authority(): return
	# Add the gravity.
	
#	if not is_on_floor():
#		velocity.y -= gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("move_jump") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#negative, pos, negative, pos
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		#$Pivot.look_at(position + direction, Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
