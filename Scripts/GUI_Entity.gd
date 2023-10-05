extends Control
@export_category('Health')
@export var health_max = 100
@export var health = 90
@export var health_regen = 1
@export var health_timeout = 2
@onready var bar_health = $Health


enum RESOURCE {
	STAMINTA,
	MANA,
	RAGE
}
@export_category('Resource')
@export var resouce_visible = false
@export var resource_max = 100
@export var resource = 50
@export var resource_regen = 5
@export var resource_timeout = 2
@onready var bar_resource = $Resource

@export_category('Other')
@onready var i_timer = $iFrame
@export var i_frames = 0.5
var health_stop = false;
var resource_stop = false;

signal damage(value)
signal cast(value)
signal deadge
func _ready():
	bar_resource = resouce_visible
	resource_stop = !resouce_visible
	
func _process(delta):
	if(!health_stop): health += (delta * health_regen)
	if(!resource_stop): resource += (delta * resource_regen)
	
	health = clampf(health, 0, 100)
	resource = clampf(resource, 0, 100)
	bar_health.value = health
	bar_resource.value = resource
	if Input.is_action_just_pressed("debug1"):
		damage.emit(10)
		print('DEBUG 1')

func _on_gone_timeout():
	visible = false;

	
func _on_resource_start_timeout():
	resource_stop = false

func _on_health_start_timeout():
	health_stop = false

func _on_deadge():
	get_parent().queue_free()
	print('deadge')

func _on_damage(value):
	if(i_timer.is_stopped()):
		health -= value
		if(health <= 0): deadge.emit()
		health_stop = true
		visible = true
		$Gone.start(4)
		$Health_Start.start(health_timeout)
		if i_frames > 0: i_timer.start(i_frames)
func _on_cast(value):
	if(value < resource):
		### cast
		pass
	else:
		#### stop logic
		pass
