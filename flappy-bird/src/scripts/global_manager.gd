extends Node

signal game_stopped
signal game_started
signal game_restarted
signal score_earned

var score: int = 0
var started: bool = false