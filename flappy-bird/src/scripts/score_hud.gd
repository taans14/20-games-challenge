extends Control

@export var digit_list: Array[String] = []
@export var score_label: RichTextLabel


func _ready() -> void:
	score_label.text = wrap_img_tag(digit_list[0])
	GlobalManager.score_earned.connect(_on_score_earned)


func _on_score_earned() -> void:
	score_label.text = score_to_string(GlobalManager.score)


func score_to_string(score: int) -> String:
	var result = ""
	
	for digit in str(score):
		result += wrap_img_tag(digit_list[int(digit)])

	return result


func wrap_img_tag(str: String) -> String:
	return "[img=40x60]" + str + "[/img]"