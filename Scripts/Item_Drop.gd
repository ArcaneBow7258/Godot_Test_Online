extends Node2D

@export var item :Item = null
@onready var sprite :Sprite2D = get_node("Sprite")

var amp = 10.0
var freq = 0.5
var time = 0

func _ready():
	pass
	
func _process(delta):
	time += delta * freq
	#if time > freq * 3:
		#time = 0
	sprite.position.y = abs(amp * sin(time))
	print(sprite.position.y)
	
	

