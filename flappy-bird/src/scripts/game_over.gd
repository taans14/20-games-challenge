extends Control


func _ready() -> void:
	gui_input.connect(_on_gui_input)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		GlobalManager.game_restarted.emit()