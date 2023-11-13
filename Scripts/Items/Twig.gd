class_name Twig extends Item

func _init():
	super._init("Twig", 64, "res://Atlas/Twig.tres")


func use():
	printerr(self.item_name + " not overwritten use()")
