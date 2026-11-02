@tool
class_name PipeSpawner
extends Node


@export var pipe: PackedScene
@export var min_y: int = 200
@export var max_y: int = 444

var pipe_arr: Array[Pipe]


func _get_configuration_warnings() -> PackedStringArray:
	if not pipe or not pipe is PackedScene:
		return ["No valid scene assigned to the PipeSpawner"]
	else:
		return []


func instantiate() -> Node:
	if not pipe:
		return null
	
	return pipe.instantiate()


func spawn(parent: Node) -> Node:
	var new_pipe := instantiate()

	pipe_arr.append(new_pipe)

	parent.add_child(new_pipe)
	new_pipe.position.y = randi_range(min_y, max_y)

	return new_pipe
