extends CharacterBody2D

var sprites = [
	"enemy1",
	"enemy2",
	"enemy3"
]

func _ready():
	$AnimatedSprite2D.animation = sprites.get(randi_range(0, 2))
