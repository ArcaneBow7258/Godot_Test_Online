extends AnimatedSprite2D
@onready var parent: CharacterBody2D = get_parent()
var last = "down"
func _physics_process(delta):
	last =  get_move_angle()
	animation = last+"_m"
	
func get_move_angle():
	var angle = parent.velocity.angle() * 180 / PI

	if(parent.velocity.length() == 0 and angle == 0):
		return last
	if(45 > angle and angle > -45):
		return "right"
	elif(135 > angle and angle > 45):
		return "down"
	elif(-45 > angle and angle > -135): 
		return "up"
	else:
		return "left"


	
