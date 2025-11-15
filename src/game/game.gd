extends Node

signal exit_game

# Scenes
@onready
var dead_screen = preload("res://src/ui/dead_screen.tscn")

# Game
var running = true

var dead_screen_instance: Node
var player_start_position: Vector2

# Speed
var speedScene = 200
var minSpeedScene = 200
var maxSpeedScene = 5100

# Timers config
var minMobTimerSpawn = 0.5
var maxMobTimerSpawn = 5

func _ready():
	player_start_position = $Player.position
	
func _process(_delta: float):
	$Player.running = running
	$Player.speed = speedScene
	
	$Score.running = running
	
	$BackgroundScene.set_speeds(speedScene, minSpeedScene, maxSpeedScene)
	$EnemyController.set_speeds(speedScene, minSpeedScene, maxSpeedScene)
	
	if Input.is_action_pressed("more_speed"):
		increase_speed()

func restart():
	$Score.save_score()
	$Score.reset()
	
	running = true
	speedScene = minSpeedScene
	$Player.position = player_start_position
	$EnemyController.clear_enemies()

	remove_child(dead_screen_instance)

func _on_player_hit(element: ObstacleStrategy):
	if (!running):
		return
	
	if (speedScene > 1000 && (!element || !element.insta_kill())):
		speedScene = minSpeedScene
		$Player.enable_temporal_transparent()
		return
	
	running = false
	dead_screen_instance = dead_screen.instantiate()
	
	add_child(dead_screen_instance)
	
	dead_screen_instance.restart.connect(restart)

func increase_speed():
	if (speedScene < maxSpeedScene):
		speedScene = speedScene + 100;
	
	print(speedScene)
	

func _on_speed_timer_timeout():
	increase_speed()


func _on_button_pressed() -> void:
	exit_game.emit()
