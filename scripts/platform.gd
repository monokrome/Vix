extends Node

onready var Voxel = preload('res://scripts/voxel.gd')

func _ready():
	self.add_child(Voxel.new())