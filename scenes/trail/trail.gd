extends Line2D


export(int) var num_points = 10
onready var target = get_parent()

func _ready():
	set_as_toplevel(true)
	clear_points()

func _process(delta):
	add_point(target.global_position, 0)
	if points.size() > num_points:
		remove_point(points.size() - 1)
