extends Node2D

const grid_size = 100
const player_sight = 12
const player_clear_sight = 6
var window_grid_width = DisplayServer.screen_get_size().x / grid_size / 2 + 5
var window_grid_height = DisplayServer.screen_get_size().y / grid_size / 2 + 5

var grid_discovered = {}
var player_x = 0
var player_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	for x in range(player_x - window_grid_width, player_x + window_grid_width):	
		for y in range(player_y - window_grid_height, player_y + window_grid_height):
			if !(str(x) in grid_discovered) || !(str(y) in grid_discovered[str(x)]):
				draw_rect(Rect2(x * grid_size, y * grid_size, grid_size, grid_size), Color.BLACK)
			else:
				draw_rect(Rect2(x * grid_size, y * grid_size, grid_size, grid_size), Color(Color.BLACK, grid_discovered[str(x)][ str(y)]))

func update_pos(param_x,param_y):
	player_x = floor(param_x / grid_size)
	player_y = floor(param_y / grid_size)
	
	for x in range(player_x - player_sight, player_x + player_sight):
		for y in range(player_y - player_sight, player_y + player_sight):
			var str_x = str(x)
			var str_y = str(y)
			if !(str_x in grid_discovered):
				grid_discovered[str_x] = {}
			if !(str_y in grid_discovered[str_x]) || grid_discovered[str_x][str_y] != 0:
				var dist_x = abs(player_x - x)
				var dist_y = abs(player_y - y)
				if dist_x > player_clear_sight || dist_y > player_clear_sight:
					grid_discovered[str_x][str_y] = 1 / max(dist_x, dist_y)
				else:
					grid_discovered[str_x][str_y] = 0
				
	queue_redraw()
