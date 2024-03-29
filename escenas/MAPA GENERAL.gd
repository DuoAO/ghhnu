extends TileMap

var astar = AStarGrid2D.new()
var map_rect = Rect2i()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var tile_size = get_tileset().tile_size
	var tilemap_size = get_used_rect().end - get_used_rect().position
	map_rect = Rect2i(Vector2i(), tilemap_size)
	
	astar.region = map_rect
	astar.cell_size = tile_size
	astar.offset = tile_size * 0.5
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coordinates = Vector2i(i, j)
			var tile_data0 = get_cell_tile_data(0, coordinates)
			var tile_data1 = get_cell_tile_data(1, coordinates)
			var tile_data2 = get_cell_tile_data(2, coordinates)
			var tile_data3 = get_cell_tile_data(3, coordinates)
			var tile_data4 = get_cell_tile_data(4, coordinates)
			if tile_data0 and tile_data0.get_custom_data('type') == 'wall':
				astar.set_point_solid(coordinates)
			if tile_data1 and tile_data1.get_custom_data('type') == 'wall':
				astar.set_point_solid(coordinates)
			if tile_data2 and tile_data2.get_custom_data('type') == 'wall':
				astar.set_point_solid(coordinates)
			if tile_data3 and tile_data3.get_custom_data('type') == 'wall':
				astar.set_point_solid(coordinates)
			if tile_data4 and tile_data4.get_custom_data('type') == 'wall':
				astar.set_point_solid(coordinates)

func is_point_walkable(local_position):
	var map_position = local_to_map(local_position)
	if map_rect.has_point(map_position):
		return not astar.is_point_solid(map_position)
	return false
