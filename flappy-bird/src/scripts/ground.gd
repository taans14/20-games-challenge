extends StaticBody2D

@export var ground_arr: Array[Area2D] = []
@export var warp_area: Area2D
@onready var prev_sprite: Area2D = ground_arr[2]

const SPRITE_LENGTH: int = 504
const SPEED: float = 200

func _ready() -> void:
	warp_area.area_entered.connect(_on_warp_area_area_entered)


func _process(delta: float) -> void:
	move_sprite(delta)


func move_sprite(delta) -> void:
	for sprite in ground_arr:
		sprite.position.x -= SPEED * delta


func _on_warp_area_area_entered(area: Node2D) -> void:
	area.position.x = prev_sprite.position.x + SPRITE_LENGTH
	prev_sprite = area as Area2D
