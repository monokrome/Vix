extends KinematicBody

export(float) var gravity = -3  # TODO: Pull gravity from environment?

export(float) var mouse_x_sensitivity_factor = 0.08
export(float) var mouse_y_sensitivity_factor = 0.08

export(float) var movement_speed_factor = 4
export(float) var acceleration_speed_factor = 0.7
export(float) var in_air_acceleration_factor = 0.02

export(float) var sprint_speed_factor = 3.4
export(float) var sprint_acceleration_factor = 1.6

export(float) var max_in_air_jumps = 2
export(float) var jump_velocity = 75


var EVENT_HANDLERS = {}

var in_air_jumps_remaining = 0

var mouse_x_sensitivity = mouse_x_sensitivity_factor
var mouse_y_sensitivity = mouse_y_sensitivity_factor

var movement = Vector3(0, 0, 0)
var jump = Vector3(0, 0, 0)


func register_handler(event_type, handler_name):
	EVENT_HANDLERS[event_type] = funcref(self, handler_name)


func _ready():
	# Set up event handlers
	register_handler('InputEventMouseMotion', 'process_mouse_motion')
	register_handler('InputEventMouseButton', 'process_mouse_button')
	register_handler('InputEventKey', 'process_key_event')

	# Capture the mouse now that the player is ready
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	set_physics_process(true)


func _exit_scene():
	""" Stop capturing the mouse if the player exits the scene. """

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta):
	var acceleration_speed
	var actual_velocity
	var destination

	# Normalize movement direction
	movement = movement.normalized()
	movement.y = gravity * delta

	actual_velocity = movement

	# Leave y as-is, since we want to use expected jump velocity.
	actual_velocity.x = movement.x * movement_speed_factor
	actual_velocity.z = movement.z * movement_speed_factor

	# Calculate our movement velocity
	destination = movement * movement_speed_factor
	acceleration_speed = acceleration_speed_factor
	
	if not self.is_on_floor():
		acceleration_speed *= in_air_acceleration_factor

	elif Input.is_key_pressed(KEY_SHIFT):
		actual_velocity *= sprint_speed_factor
		acceleration_speed *= sprint_acceleration_factor

	actual_velocity = actual_velocity.linear_interpolate(movement+jump, delta * acceleration_speed)

	self.move_and_slide(actual_velocity, Vector3(0, 1, 0))
	
	# Recent jump after applying it
	jump = Vector3(0, 0, 0)

func process_key_event(event):
	""" Process specific key events. """
	
	# This button was space
	if event.pressed and event.scancode == 32:
		self.process_jump(event)


func process_mouse_motion(event):
	""" The mouse was moved. """

	var camera = self.get_node('Viewpoint')

	camera.rotation.y += mouse_y_sensitivity * (event.relative.x * -1) * get_process_delta_time()
	camera.rotation.x += mouse_x_sensitivity * (event.relative.y * -1) * get_process_delta_time()


func process_mouse_button(event):
	""" A mouse button has been pressed. """


func process_movement(event):
	# TODO: When looking up and down, this gets messy. Fix that.
	# TODO: Translate keys to actions.

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


func process_jump(event):
	if self.is_on_floor():
		in_air_jumps_remaining = max_in_air_jumps

	elif in_air_jumps_remaining == 0:
		return

	else:
		in_air_jumps_remaining -= 1

	jump.y = jump_velocity


func _input(event):
	process_movement(event)

	var event_type = event.get_class()
	
	if EVENT_HANDLERS.has(event_type) == false:
		return

	EVENT_HANDLERS[event_type].call_func(event)