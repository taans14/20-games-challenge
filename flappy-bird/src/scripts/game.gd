extends Node


@export var pipe_spawner: Node
@export var pipe_despawner : Area2D
@export var pipe_spawn_timer: Timer
@export var pipes: Node2D
@export var start_menu: Control
@export var score_hud: Control
@export var game_over: Control


func _ready() -> void:
	pipe_spawn_timer.timeout.connect(_on_timer_timeout)
	pipe_despawner.area_entered.connect(_on_pipe_despawner_area_entered)
	GlobalManager.game_stopped.connect(_on_game_stopped)
	GlobalManager.game_started.connect(_on_game_started)
	GlobalManager.game_restarted.connect(_on_game_restarted)
	GlobalManager.started = false
	GlobalManager.score = 0
	get_tree().paused = true


func _on_timer_timeout() -> void:
	pipe_spawner.spawn(pipes)


func _on_pipe_despawner_area_entered(body: Node2D) -> void:
	var pipe = body.get_parent() as Pipe
	pipe_spawner.pipe_arr.erase(pipe)
	pipe.queue_free()


func _on_game_stopped() -> void:
	game_over.visible = true
	get_tree().paused = true


func _on_game_started() -> void:
	start_menu.visible = false
	score_hud.visible = true
	get_tree().paused = false


func _on_game_restarted() -> void:
	get_tree().reload_current_scene()
