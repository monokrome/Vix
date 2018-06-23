extends Node

onready var VoxelPlane = preload('res://scripts/voxel_plane.gd')

func _ready():
	self.add_child(VoxelPlane.new())