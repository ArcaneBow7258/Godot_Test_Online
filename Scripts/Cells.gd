extends Node2D

@export var width = 64;
@export var height = 64;
@export var percent_fill = 0.8;
@export var smooths = 1
@export var seed = 0;
@export var random_seed = false;
@export var draw_size = 4
var map = []

func _ready():
	generate_map()
	
	
func generate_map():
	
	random_fill()
	for s in smooths:
		smooth()
		
func random_fill():
	var rng = RandomNumberGenerator.new()
	if(!random_seed): rng.seed = seed
	for x in width:
		for y in height:
			if(x == 0 || x == width - 1 || y == 0 || y == height - 1):
				map.append(1)
				continue
			map.append(1 if rng.randf() < percent_fill else 0)
			
			
func smooth():
	for x in width:
		for y in height:
			var walls = get_surrounding(x, y)
			if(walls > 4):
				map[x + y*width] = 1
			elif (walls <= 4):
				map[x + y*width] = 0

func get_surrounding(x, y):
	var walls = 0
	for xl in range (x-1, x+2):
		for yl in range (y-1, y+2):
			if(xl >= 0 && xl < width && yl >= 0 && yl < height): 
				#if(xl != x || yl != y):
					walls += map[xl + yl*height]
			else: 
				walls += 1
	return walls
func _draw():
	draw_size = 4;
	for x in width:
		for y in height:
			var cell = map[x + y*width]
			var col =  Color.BLACK
			if(cell == 0):
				col = Color.WHITE
			draw_rect(Rect2(x * draw_size, y * draw_size,draw_size, draw_size),col, true)
