extends Node2D

@export var speed: float = 200
@export var minSpeed: float = 200
@export var maxSpeed: float = 1100

var speedScaleBase = 1.0

func _process(delta: float):
	$AnimatedSprite2D.speed_scale = speedScaleBase + (((speed - minSpeed) / 1100) * 3)
