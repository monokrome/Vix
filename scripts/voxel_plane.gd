extends Node

export(Vector2) var size = Vector2(100, 100)

onready var Voxel = preload('res://scripts/voxel.gd')

func _ready():
	var v
	for x in range(size.x):
		for y in range(size.y):
			v = Voxel.new()
			v.position = Vector3(x, 0, y)
			self.add_child(v)