extends NavigationAgent2D
enum aggro_type{
	NEAREST = 0,
	FIRST = 1,
	HIT = 2
}
@export var SPEED = 100.0
@export var DETECTION = 64
@export var aggro: aggro_type = aggro_type.NEAREST
@onready var detected_entities = get_tree().get_nodes_in_group("Friendly")

@onready var parent = get_parent()
@onready var area = $Detector

func _physics_process(delta):
	
		
	if(len(detected_entities) < 1): return
	var current_location =  parent.global_transform.origin
	detected_entities.sort_custom(func(a,b): return parent.global_position.distance_to(a) > parent.global_position.distance_to(b))
	target_position = (detected_entities[0] as CollisionShape2D).global_position
	if(is_target_reached()):
		parent.velocity  = Vector2.ZERO;
		return
		#Attack logic?
	var next_location = get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	parent.velocity = new_velocity

	
	parent.move_and_slide()
	
func update_targes():
	detected_entities = get_tree().get_nodes_in_group("Friendly")
	


func _on_detector_body_entered(body):
	if(body.is_in_group("Friendly")):
		detected_entities.append(body)


func _on_detector_body_exited(body):
	if(body.is_in_group("Friendly")):
		detected_entities.remove_at(detected_entities.find(body))

