extends AnimatedSprite2D
@onready var parent: CharacterBody2D = get_parent()

func _physics_process(delta):
	animation =  get_move_angle()+"_m"
	
func get_move_angle():
	var angle = parent.velocity.angle() * 180 / PI
	#print(angle)
	if(45 > angle and angle > -45):
		return "right"
	if(135 > angle and angle > 45):
		return "down"
	if(-45 > angle and angle > -135):
		return "up"
	return "left"
