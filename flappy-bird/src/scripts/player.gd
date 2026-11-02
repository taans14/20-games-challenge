class_name Player
extends CharacterBody2D

@export var _fall_rotation_speed: float = TAU / 2
@export var _jump_rotation_speed: float = TAU
@export var logic_area: Area2D
@export var sprite: AnimatedSprite2D
@export var player_audio_stream: AudioStreamPlayer2D

var dead: bool

const SPEED: float = 1.2
const JUMP_VELOCITY: float = -300.0
const UP_DIRECTION: int = -30
const DOWN_DIRECTION: int = 90


func _ready() -> void:
	dead = false
	logic_area.body_entered.connect(_on_logic_area_body_entered)


func _process(delta: float) -> void:
	move(delta)
	rotate_pivot(delta)


func rotate_pivot(delta: float) -> void:
	if velocity.y > 0:
		rotation += _fall_rotation_speed * delta
	elif velocity.y < 0:
		rotation += _jump_rotation_speed * delta * -1.0
	
	rotation_degrees = clamp(rotation_degrees, UP_DIRECTION, DOWN_DIRECTION)


func move(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * SPEED * delta

	# Handle jump.
	if not dead and Input.is_action_just_pressed("jump"):
		if not GlobalManager.started:
			GlobalManager.game_started.emit()
			GlobalManager.started = true
		velocity.y = JUMP_VELOCITY * SPEED
		player_audio_stream.play()

	move_and_slide()


func die() -> void:

	dead = true

	logic_area.queue_free()

	if not player_audio_stream.playing:
		player_audio_stream.play()
	
	var playback: AudioStreamPlaybackInteractive = player_audio_stream.get_stream_playback()
	if playback:
		playback.switch_to_clip_by_name("die")

	GlobalManager.game_stopped.emit()

	sprite.stop()


func _on_logic_area_body_entered(body: Node2D) -> void:
	die()
