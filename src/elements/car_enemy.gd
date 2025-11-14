extends ObstacleStrategy

class_name CarEnemy

var sprites = [
	"enemy1",
	"enemy2",
	"enemy3"
]
var speed = 100

func _ready():
	$AnimatedSprite2D.animation = sprites.get(randi_range(0, 2))

func _process(delta: float):
	var velocity = Vector2.ZERO
	velocity.y = speed
	
	position += velocity * delta
	$".".move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_timer_timeout():
	speed *= 1.2

func insta_kill() -> bool:
	return false
	
func set_speed(v: float) -> void:
	speed = v
