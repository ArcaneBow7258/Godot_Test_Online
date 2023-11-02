class_name  Item_Tool extends Item
var area_type: Enums.Area_Type
var area : float
var damage : float
var durability_max : int
var durability : int
var break_type: Enums.Break_Type
var use_last = 0
var use_time : float
func _init(item_name, area_type, area, damage, durability_max, break_type, use_time, stack_max = 1):
	super._init(item_name, stack_max)
	self.area_type = area_type
	self.area = area
	self.damage = damage
	self.durability_max = durability_max
	self.durability = durability
	self.break_type = break_type
	self.use_time = use_time

func use():
	#https://docs.godotengine.org/en/stable/tutorials/physics/ray-casting.html
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape # Need to create resources for the shapes and preload it in enums?
	space_state.intersect_shape(query, 5) # 5 is max items hit?
	#PhysicsShapeQueryParameters2D
	#cast.get_collider()
