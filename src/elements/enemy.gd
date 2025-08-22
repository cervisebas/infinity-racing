extends CharacterBody2D

var sprites = [
	"enemy1",
	"enemy2",
	"enemy3"
]
@export var speed = 100

func _ready():
	$AnimatedSprite2D.animation = sprites.get(randi_range(0, 2))

func _process(delta: float):
	var velocity = Vector2.ZERO
	velocity.y = speed
	
	position += velocity * delta
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
