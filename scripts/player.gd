extends KinematicBody

const MAX_SLOPE_ANGLE = 40

export(float) var mouse_x_sensitivity_factor = 0.08
export(float) var mouse_y_sensitivity_factor = 0.08

export(float) var movement_speed_factor = 15
export(float) var acceleration_speed_factor = 15


var EVENT_HANDLERS = {}

var mouse_x_sensitivity = mouse_x_sensitivity_factor
var mouse_y_sensitivity = mouse_y_sensitivity_factor

var movement = Vector3(0, 0, 0)


func register_handler(event_type, handler_name):
	EVENT_HANDLERS[event_type] = funcref(self, handler_name)


func _ready():
	# Set up event handlers
	register_handler('InputEventMouseMotion', 'process_mouse_motion')
	register_handler('InputEventMouseButton', 'process_mouse_button')

	# Capture the mouse now that the player is ready
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	set_physics_process(true)


func _exit_scene():
	""" Stop capturing the mouse if the player exits the scene. """

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	var destination
	var actual_velocity

	# Normalize movement direction
	movement = movement.normalized()
	movement.y = 0

	actual_velocity = movement * movement_speed_factor

	# Calculate our movement velocity
	destination = movement * movement_speed_factor

	actual_velocity = actual_velocity.linear_interpolate(movement, delta * acceleration_speed_factor)

	self.move_and_slide(actual_velocity, Vector3(0, movement_speed_factor, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))


func process_mouse_motion(event):
	""" The mouse was moved. """

	var camera = self.get_node('Viewpoint')

	camera.rotation.y += mouse_y_sensitivity * (event.relative.x * -1) * get_process_delta_time()
	camera.rotation.x += mouse_x_sensitivity * (event.relative.y * -1) * get_process_delta_time()


func process_mouse_button(event):
	""" A mouse button has been pressed. """

	if not event.pressed:
		return


func process_movement(event):
	# TODO: When looking up and down, this gets messy. Fix that.

	var camera = self.get_node("Viewpoint")

	# Reset movement speed before calculating
	movement = Vector3(0, 0, 0)
	
	# We need the camera's transformation data to calculate the direction we are facing
	var camera_transform = camera.get_transform()

	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S):
		movement.y = get_process_delta_time()

	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_D):
		movement.x = get_process_delta_time()

	if Input.is_key_pressed(KEY_S):
		movement.y *= -1

	if Input.is_key_pressed(KEY_A):
		movement.x *= -1

	movement += (camera.get_global_transform().basis.z.normalized() * -1) * movement.y
	movement += camera.get_global_transform().basis.x.normalized() * movement.x	


func _input(event):
	process_movement(event)
	
	var event_type = event.get_class()
	
	if EVENT_HANDLERS.has(event_type) == false:
		return

	EVENT_HANDLERS[event_type].call_func(event)