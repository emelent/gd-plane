extends TouchScreenButton
tool
# Gonkee's joystick script for Godot 3 - full tutorial https://youtu.be/uGyEP2LUFPg
# If you use this script, I would prefer if you gave credit to me and my channel

# Change these based on the size of your button and outer sprite
export var boundary = 64 setget set_boundary
export var return_accel = 20
export var threshold = 10

onready var radius = (normal.get_size() * scale) / 2
var ongoing_drag = -1
	
signal joystick_value

var travelled = Vector2.ZERO

func _ready():
	set_process(!Engine.editor_hint)
	

func _draw():
	if !Engine.editor_hint: return
	var rad = (normal.get_size() * scale) / 1
	var color = Color.green
	color.a = 0.2
	draw_circle(position + rad, boundary, color)
	
func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2.ZERO - radius) - position
		position += pos_difference * return_accel * delta
		
	if GameManager.player == null: return
	
	var player_vel = GameManager.player.velocity * delta
	travelled += player_vel
	get_parent().global_position += player_vel
	emit_signal("joystick_value", get_value())

func set_boundary(value):
	boundary = value
	update()
	
func get_button_pos():
	return position + radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_pos = event.position + travelled
		var event_dist_from_centre = (event_pos - get_parent().global_position).length()

		if event_dist_from_centre <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event_pos - radius * global_scale)

			if get_button_pos().length() > boundary:
				set_position(get_button_pos().normalized() * boundary - radius)

			ongoing_drag = event.get_index()
		else:
			# get_parent().set_global_position(event.position)
			pass

	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

			
		
func get_value():
	if get_button_pos().length() > threshold:
		return get_button_pos().normalized()
	return Vector2.ZERO
