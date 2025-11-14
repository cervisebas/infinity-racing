extends CharacterBody2D

signal hit

@export var speed = 200
@export var maxSpeed = 200

@export var running: bool

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	$".".z_index = 10

func _process(delta):
	if (!running):
		return
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	var _speed = speed
	if (speed > maxSpeed):
		_speed = maxSpeed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * _speed
	
	position += velocity * delta
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if (collision.get_collider().is_in_group("Enemigo")):
			hit.emit()
	
	position = position.clamp(Vector2.ZERO, screen_size)

func enable_temporal_transparent():
	collision_mask = 1
	$AnimatedSprite2D.modulate.a = 0.7
	$TransparentTimer.start()

func _on_body_entered(_body):
	hit.emit()

func _on_transparent_timer_timeout():
	collision_mask = 1 | 2
	#$CollisionShape2D.disabled = false
	$AnimatedSprite2D.modulate.a = 1
