extends TileMap

enum {NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST}

func _ready():
	generate_connected_squares(8, Vector2(0, 0), 5, NORTHWEST)

#Returns true if the tile is unassigned
func is_tile_empty_v(vec):
	return get_cellv(vec) == -1

func generate_square(size, starting_cell):
	for i in range(size):
		for j in range(size):
			set_cell(starting_cell.x - i, starting_cell.y - j, 1)


func generate_connected_squares(size, starting_cell, amount, direction):
	match direction:
		NORTHWEST:
			#Generate squares
			for h in range(amount):
				for i in range(size):
					for j in range(size):
						set_cell(starting_cell.x - i - ((size + 2) * h), starting_cell.y - j, 0)
						#Generate bridges
						if h != 0:
							if size % 2 == 0:	#If size is even
								set_cell(0 - ((size + 2) * h) + 2, (0 - size) / 2, 0)
								set_cell(0 - ((size + 2) * h) + 1, (0 - size) / 2, 0)
								set_cell(0 - ((size + 2) * h) + 2, (1 - size) / 2, 0)
								set_cell(0 - ((size + 2) * h) + 1, (1 - size) / 2, 0)
							else:
								set_cell(0 - ((size + 2) * h) + 2, (0 - size) / 2, 0)
								set_cell(0 - ((size + 2) * h) + 1, (0 - size) / 2, 0)
		NORTHEAST:
			for i in range(size):
				for j in range(size):
					set_cell(starting_cell.x - i, starting_cell.y - j, 1)
		SOUTHWEST:
			for i in range(size):
				for j in range(size):
					set_cell(starting_cell.x - i, starting_cell.y - j, 1)
		SOUTHEAST:
			for i in range(size):
				for j in range(size):
					set_cell(starting_cell.x - i, starting_cell.y - j, 1)
