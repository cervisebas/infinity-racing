extends CharacterBody2D

signal  hit

@export var speed = 200
@export var min_speed = 100
var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if (speed > min_speed):
		speed -= 5
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		speed += 7
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		speed += 7
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if (collision.get_collider().is_in_group("Estructura")):
			print("Choque con una estructura")
	
	position = position.clamp(Vector2.ZERO, screen_size)



func _on_body_entered(_body):
	#hide()
	hit.emit()
	print("choque")
	#$CollisionShape2D.set_deferred("disabled", true).
