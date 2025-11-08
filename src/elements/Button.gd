extends Node2D

@export var label = ""
@export var color_label = "#FFFFFF"
@export var color = "#FF0000"

signal _on_press

func _process(delta: float):
	$Node2D/Label.text = label
	$Node2D/Label.label_settings.font_color = color_label
	$Node2D/Control/ColorRect.color = color
	



func _on_button_pressed() -> void:
	_on_press.emit()
