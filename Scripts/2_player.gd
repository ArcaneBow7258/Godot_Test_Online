extends CharacterBody2D

@onready var camera = $Camera
@export var SPEED = 5.0
@onready var sprite = $Sprite
@onready var follower_mouse = $Follower_mouse

var animation_string = "down_s"
# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	if not is_multiplayer_authority(): return
	camera.current = true


func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	
func _physics_process(delta):
	#if not is_multiplayer_authority(): return
	animation_string = move_mouse() +  move_wasd(delta)
	sprite.animation = animation_string
	move_and_slide()
	
func move_mouse():
	#if not is_multiplayer_authority(): return
	var mousePos = get_viewport().get_mouse_position()
	var middle: Vector2 = get_viewport().size / 2
	#Cooridnates start at top left, so we need to flip it, since up and left are negative, while down an right is positve:
	var mousePosNormalized = ((mousePos - middle) / middle).normalized()
#	#Clockwise starting  at (1, 0)
	camera.draw
	var angle = mousePosNormalized.angle() * 180 / PI
	follower_mouse.rotation_degrees = angle
	#print(angle)
	if(45 > angle and angle > -45):
		return "right"
	if(135 > angle and angle > 45):
		return "down"
	if(-45 > angle and angle > -135):
		return "up"
	return "left"
func move_wasd(delta):
	#if not is_multiplayer_authority(): return
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (Vector2(input_dir.x,input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		return "_m"
		#$Pivot.look_at(position + direction, Vector3.UP)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		return "_s"
