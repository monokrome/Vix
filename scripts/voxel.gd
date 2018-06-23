extends ImmediateGeometry

export(Vector3) var position = Vector3(0, 0, 0)
export(float)   var size = 1.0

func _ready():
	var opposite = Vector3(
		position.x + size,
		position.y + size,
		position.z + size
	)

	# Begin drawing
	self.begin(Mesh.PRIMITIVE_TRIANGLES, null)

	# Top
	self.add_vertex(Vector3(position.x, opposite.y, position.z))
	self.add_vertex(Vector3(position.x, opposite.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))

	self.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, opposite.y, position.z))
	self.add_vertex(Vector3(position.x, opposite.y, position.z))

	# Right Side
	self.add_vertex(Vector3(opposite.x, opposite.y, position.z))
	self.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, position.y, opposite.z))

	self.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, position.y, position.z))
	self.add_vertex(Vector3(opposite.x, opposite.y, position.z))

	# Bottom
	self.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, position.y, position.z))
	self.add_vertex(Vector3(position.x, position.y, position.z))

	self.add_vertex(Vector3(position.x, position.y, position.z))
	self.add_vertex(Vector3(position.x, position.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, position.y, opposite.z))

	# Rear side
	self.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, opposite.y, opposite.z))
	self.add_vertex(Vector3(position.x, opposite.y, opposite.z))

	self.add_vertex(Vector3(position.x, position.y, opposite.z))
	self.add_vertex(Vector3(opposite.x, position.y, opposite.z))
	self.add_vertex(Vector3(position.x, opposite.y, opposite.z))

	# Left Side
	self.add_vertex(Vector3(position.x, opposite.y, position.z))
	self.add_vertex(Vector3(position.x, opposite.y, opposite.z))
	self.add_vertex(Vector3(position.x, position.y, opposite.z))

	self.add_vertex(Vector3(position.x, position.y, opposite.z))
	self.add_vertex(Vector3(position.x, position.y, position.z))
	self.add_vertex(Vector3(position.x, opposite.y, position.z))

	# Front side
	self.add_vertex(Vector3(opposite.x, position.y, position.z))
	self.add_vertex(Vector3(opposite.x, opposite.y, position.z))
	self.add_vertex(Vector3(position.x, opposite.y, position.z))

	self.add_vertex(Vector3(position.x, position.y, position.z))
	self.add_vertex(Vector3(opposite.x, position.y, position.z))
	self.add_vertex(Vector3(position.x, opposite.y, position.z))

	# Finish drawing
	self.end()