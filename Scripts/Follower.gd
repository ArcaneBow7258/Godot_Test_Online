extends CharacterBody3D


@export var SPEED = 3.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav_agent: NavigationAgent3D  = $NavigationAgent3D

func _physics_process(delta):
	var current_location =  global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = new_velocity

	
	move_and_slide()
	
func update_target_location(target_location):
	nav_agent.target_position = target_location
	
