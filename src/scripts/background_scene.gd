extends Node2D

func set_speeds(
	speedScene: float,
	minSpeedScene: float,
	maxSpeedScene: float
):
	$Asphalt.speed = speedScene
	$Asphalt.minSpeed = minSpeedScene
	$Asphalt.maxSpeed = maxSpeedScene
