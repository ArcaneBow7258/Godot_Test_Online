extends HBoxContainer


@export var current_select = 1
@onready var box_cursor = $"Box1/Box Cursor"
func _ready():
	pass

func _process(delta):
	
	
func _input(event):
	if event.is_action_just_pressed("slot1"): current_select = 1
	if event.is_action_just_pressed("slot2"): current_select = 2
	if event.is_action_just_pressed("slot3"): current_select = 3
	if event.is_action_just_pressed("slot4"): current_select = 4
	box_cursor.reparent(get_node("Box"+str(current_select)),false)
func add_item(item):
	var box_node = get_node("Box"+str(current_select))
