class_name  Item extends CanvasItem # So I can access the world
var stackable 
var stack_max 
var item_name
var image_path 
func _init(item_name, stack_max = 64, image_path = null):
	self.item_name = item_name
	self.stack_max = stack_max
	self.stackable = self.stack_max > 1


func use():
	printerr(name + " not overwritten use()")
