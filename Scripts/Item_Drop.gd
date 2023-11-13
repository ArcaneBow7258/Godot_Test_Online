extends RigidBody2D

var item = Twig.new.call()
@export var stack_size = 1
@onready var sprite :Sprite2D = get_node("Sprite")

var amp = 10.0
var freq = 2
var time = 0

func _ready():
	print(item)
	print(item.stack_max)
	if item.image_path != null:
		sprite.texture = load(item.image_path)
	pass
	
func _process(delta):
	time += delta * freq
	if time > freq * 3:
		time = 0
	sprite.position.y = abs(amp * sin(time))

func _physics_process(delta):
	
	move_and_collide(linear_velocity * delta)
	#print(sprite.position.y)
	
	

