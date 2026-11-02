class_name Pipe
extends Node2D

signal pipe_collided

@export var collision_zone: Area2D
@export var score_zone: Area2D
@export var pipe_audio_stream: AudioStreamPlayer2D

const SPEED: float = 200


func _ready() -> void:
	collision_zone.area_entered.connect(_on_collision_zone_area_entered)
	score_zone.area_exited.connect(_on_score_zone_area_exited)


func _process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	position.x -= SPEED * delta


func _on_collision_zone_area_entered(area: Area2D) -> void:
	pipe_collided.emit()
	var player = area.get_parent()
	if player is Player:
		player.die()


func _on_score_zone_area_exited(area: Area2D) -> void:
	pipe_audio_stream.play()
	GlobalManager.score += 1
	GlobalManager.score_earned.emit()