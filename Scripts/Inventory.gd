extends Control


@export var current_select = 1
@onready var box_cursor = $"Hotbar/Box1/Box Cursor"
var relative_hotbar = "Hotbar/" # Relatvie path to access hotbar cursor
var swap_slot = null
func _ready():
	pass

func _process(delta):
	pass
	
func _input(event):
	if event.is_action_pressed("slot1"): current_select = 1
	if event.is_action_pressed("slot2"): current_select = 2
	if event.is_action_pressed("slot3"): current_select = 3
	if event.is_action_pressed("slot4"): current_select = 4
	box_cursor.reparent(get_node(relative_hotbar + "Box"+str(current_select)),false)
	
	if event.is_action_pressed("Inventory"): visible = !visible
func add_item(item):
	#var box_node = get_node("Box"+str(current_select))
	print("Added item")

func swap_item(node_box):
	if(not swap_slot): #selected 1
		swap_slot = node_box
	else: #selected a 2nd one
		var temp = node_box.item
		node_box.item = swap_slot.item
		swap_slot.item = temp
		print('Swapped', node_box.item, "And", swap_slot.item)
		node_box.set_pressed(false)
		swap_slot.set_pressed(false)
		#swap_slot = null
	print(swap_slot)
