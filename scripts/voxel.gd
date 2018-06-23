extends Node

export(Vector3) var position = Vector3(0, 0, 0)
export(float)   var size = 1.0

func generate_voxel():
	var geometry = ImmediateGeometry.new()
	
	var opposite = Vector3(
		position.x + size,
		position.y + size,
		position.z + size
	)

	# Begin drawing
	geometry.begin(Mesh.PRIMITIVE_TRIANGLES, null)

	# Top
	geometry.add_vertex(Vector3(position.x, opposite.y, position.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))

	geometry.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, opposite.y, position.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, position.z))

	# Right Side
	geometry.add_vertex(Vector3(opposite.x, opposite.y, position.z))
	geometry.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, position.y, opposite.z))

	geometry.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, position.y, position.z))
	geometry.add_vertex(Vector3(opposite.x, opposite.y, position.z))

	# Bottom
	geometry.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, position.y, position.z))
	geometry.add_vertex(Vector3(position.x, position.y, position.z))

	geometry.add_vertex(Vector3(position.x, position.y, position.z))
	geometry.add_vertex(Vector3(position.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, position.y, opposite.z))

	# Rear side
	geometry.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, opposite.z))

	geometry.add_vertex(Vector3(position.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, opposite.z))

	# Left Side
	geometry.add_vertex(Vector3(position.x, opposite.y, position.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, opposite.z))
	geometry.add_vertex(Vector3(position.x, position.y, opposite.z))

	geometry.add_vertex(Vector3(position.x, position.y, opposite.z))
	geometry.add_vertex(Vector3(position.x, position.y, position.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, position.z))

	# Front side
	geometry.add_vertex(Vector3(opposite.x, position.y, position.z))
	geometry.add_vertex(Vector3(opposite.x, opposite.y, position.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, position.z))

	geometry.add_vertex(Vector3(position.x, position.y, position.z))
	geometry.add_vertex(Vector3(opposite.x, position.y, position.z))
	geometry.add_vertex(Vector3(position.x, opposite.y, position.z))

	# Finish drawing
	geometry.end()

	return geometry

func _ready():	
	self.add_child(generate_voxel())