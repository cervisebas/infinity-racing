extends Node2D

signal restart

func _on_button__on_press() -> void:
	restart.emit()
