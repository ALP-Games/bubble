extends Panel

@export var stock_update_delay := 0.25
var stock_update_elapsed := 0.0

var stock_prices : Array[int] = [0, 1]
var max_points := 20  # Maximum points on the graph


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	stock_update_elapsed += delta
	if stock_update_elapsed < stock_update_delay:
		return
	stock_update_elapsed -= stock_update_delay
	#
	## Simulate stock price changes (add a random value)
	#if stock_prices.size() >= max_points:
		#stock_prices.pop_front()  # Remove the oldest value
	#stock_prices.append(stock_prices[-1] + randf_range(-5, 5))  # Add a new value
	#draw.emit()
	queue_redraw() # Redraw the graph


func _draw():
	# Calculate graph size and draw
	var graph_size = get_rect().size
	var min_price = 0
	var max_price = stock_prices.max()
	var points = []

	for i in range(stock_prices.size()):
		var x = graph_size.x * (i / float(stock_prices.size() - 1))
		var y = graph_size.y * (1 - ((stock_prices[i] - min_price) / (max_price - min_price)))
		points.append(Vector2(x, y))
	
	draw_polyline(points, Color(0, 1, 0), 2)  # Green line
