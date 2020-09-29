extends KinematicBody2D


export(float) var speed = 50.0
export(float) var acceleration = 4.0
export(float) var rotation_speed = 1.0
const max_rotation = 180
var direction = Vector2.ZERO
var velocity = Vector2.ZERO



func _ready():
	GameManager.player = self
	var joystick = get_parent().get_node("HUD/Joystick/Button")
	if joystick:
		joystick.connect("joystick_value", self, "_on_joystick_value")

func _process(delta):
	pass
#	if Input.is_action_pressed("move_down"):
#		# rotate plane downards
#		rotation_degrees = min(max_rotation, rotation_degrees + rotation_speed)
#		pass
#
#	elif Input.is_action_pressed("move_up"):
# 1		rotation_degrees = max(-max_rotation, rotation_degrees - rotation_speed)
#
func _physics_process(delta):
	# velocity = direction * speed * delta
	rotation = velocity.angle()
	move_and_collide(velocity * delta)


func _on_joystick_value(value: Vector2):
#	rotation_degrees = value.y * max_rotation
	velocity = (velocity + acceleration * value).clamped(speed)
	

