extends TileSet
# "tool" makes this also apply when placing tiles by hand in the tilemap editor too.
tool
const dirt = 1
const dirt_grass = 2
const stone = 3
const stone_grass = 4
const sand = 5
const sand_grass = 6
const dreamstone = 7
const dreamstone_grass = 8
var binds = {
	dirt: [dirt_grass],
	stone: [stone_grass],
	sand: [sand_grass],
	dreamstone: [dreamstone_grass],
	dirt_grass: [dirt],
	stone_grass: [stone],
	sand_grass: [sand],
	dreamstone_grass: [dreamstone],
}

func _is_tile_bound(id, neighbour_id):
	return neighbour_id in get_tiles_ids()
#func _is_tile_bound(id, neighbour_id):
#	if id in binds:
#		return neighbour_id in binds[id]
#	return false
