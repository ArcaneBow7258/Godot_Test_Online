class_name  Item extends CanvasItem # So I can access the world
var stack_size = 1
var stack_max = 1
var item_name = ""
func _init(item_name, stack_max = 64):
	self.item_name = item_name
	self.stack_max = stack_max


func use():
	printerr(name + " not overwritten use()")
