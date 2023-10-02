extends TileMap
const script_cells = preload("res://Scripts/Cells.gd")
var cells = null
func _draw():
	if(cells):
		var draw_size = 4;
		for x in cells.width:
			for y in cells.height:
				var cell = cells.map[x + y*cells.width]
				var col =  Color.BLACK
				if(cell == 0):
					col = Color.WHITE
				draw_rect(Rect2(x * draw_size, y * draw_size,draw_size, draw_size),col, true)

func _process(delta):
	queue_redraw()
func  _ready():
	cells = script_cells.new()
	var map_fill = []
	var map_empty = []
	cells.width = 16
	cells.height = 16
	cells.percent_fill = .4
	cells.smooths = 2
	cells.random_seed = true
	cells.generate_map();
	
	
	for x in cells.width:
		for y in cells.height:
			if(cells.map[x + y*cells.width] == 1):
				map_fill.append(Vector2i(x,y))
			else:
				map_empty.append(Vector2i(x,y))
	set_cells_terrain_connect(1,map_fill,0,0, false)
	set_cells_terrain_connect(2,map_empty,0,2, false)
	
	#set_cells_terrain_connect(1,map_fill,0,0, false)
	
	
	
	## Making things look pretty
	var tiles_ignore = [Vector2i(1,1), Vector2i(1,4)]
	var test = get_navigation_map(3)
	#upper, genearte floor?
	var tiles_used = []
	for x in 4+1:
		for y in 5+1:
			if(Vector2i(x,y) in tiles_ignore): continue
			tiles_used.append_array(get_used_cells_by_id(0, 0, Vector2i(x,y)))
	#print("Found tiles: ", len(tiles_used))
	for cords in tiles_used:
		set_cell(3, cords, 0, Vector2i(1,1), 1)
			#erase_cell(0, cords)
	tiles_used = []
	#ground, generate water
	for x in 4+1:
		for y in 5+1:
			if(Vector2i(x,y) in tiles_ignore): continue
			tiles_used.append_array(get_used_cells_by_id(1, 0, Vector2i(x,y)))
			
	print("Found tiles: ", len(tiles_used))
	for cords in tiles_used:
		set_cell(3, cords, 1, Vector2i(1,0), 0)
			#erase_cell(0, cords)

	
