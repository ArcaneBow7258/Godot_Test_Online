extends TextureButton
@onready var item = self.name
#var item = Item("Test")
func _ready():
	pass
func _process(delta):
	pass
	

func add_item(item):
	pass
	
func _toggled(toggled):
	if(toggled):
		if(not UILayer.get_node("%Inventory").swap_slot):
			UILayer.get_node("%Inventory").swap_slot = self
		else:
			var temp = item
			item = UILayer.get_node("%Inventory").swap_slot.item
			UILayer.get_node("%Inventory").swap_slot.item = temp
			print('Swapped', item, "And", UILayer.get_node("%Inventory").swap_slot.item)
			UILayer.get_node("%Inventory").swap_slot.set_pressed(false)
			self.set_pressed(false)
			UILayer.get_node("%Inventory").swap_slot = null
	else:
		UILayer.get_node("%Inventory").swap_slot = null
	
