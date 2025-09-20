extends Node

@onready var spawn_points = $SpawnPoints.get_children()
@onready var dead_screen = preload("res://src/ui/dead_screen.tscn")

@onready var LM2D = $SpawnPoints/LeftMarker2D
@onready var CM2D = $SpawnPoints/CenterMarker2D
@onready var RM2D = $SpawnPoints/RightMarker2D

@export var mob_scene: PackedScene
#var score
var running = true

# Speed
var speedScene = 200
var minSpeedScene = 200
var maxSpeedScene = 5100

# Timers config
var minMobTimerSpawn = 0.5
var maxMobTimerSpawn = 5

var dead_screen_instance: Node
var player_start_position: Vector2

func _ready():
	print("start")
	player_start_position = $Player.position
	
func _process(delta: float):
	$Player.running = running
	$Player.speed = speedScene
	
	$Asphalt.speed = speedScene
	$Asphalt.minSpeed = minSpeedScene
	$Asphalt.maxSpeed = maxSpeedScene
	
	var mobTimerSpawn = float(maxSpeedScene) / float(speedScene)
	if (mobTimerSpawn < minMobTimerSpawn):
		mobTimerSpawn = minMobTimerSpawn
	elif (mobTimerSpawn > maxMobTimerSpawn):
		mobTimerSpawn = maxMobTimerSpawn
	
	if ($MobTimer.wait_time != mobTimerSpawn):
		$MobTimer.wait_time = mobTimerSpawn
	
	for enemy in $Enemies.get_children():
		enemy.speed = speedScene / 2
		
	if Input.is_action_pressed("more_speed"):
		increase_speed()

@onready var markers = [
	$LeftMarker2D,
	$CenterMarker2D,
	$RightMarker2D
]

@onready var spawn_patterns = [
	[LM2D, null, null],
	[LM2D, CM2D, null],
	[LM2D, null, RM2D],
	[null, CM2D, null],
	[null, null, RM2D],
	[null, CM2D, RM2D],
]

@onready var last_pattern = spawn_patterns[0]

func _on_mob_timer_timeout():
	if (!running):
		return
	
	var use_pattern = spawn_patterns.pick_random()
	
	while (last_pattern == use_pattern):
		use_pattern = spawn_patterns.pick_random()
	
	last_pattern = use_pattern
	
	for marker in use_pattern:
		if (marker == null):
			continue
		
		var enemy = mob_scene.instantiate()
		enemy.position = marker.position
		
		enemy.speed = randi_range(100, 300)
		
		$Enemies.add_child(enemy)
		

func restart():
	running = true
	speedScene = minSpeedScene
	$Player.position = player_start_position
	
	for enemy in $Enemies.get_children():
		$Enemies.remove_child(enemy)

	remove_child(dead_screen_instance)

func _on_player_hit():
	if (!running):
		return
	
	if (speedScene > 1000):
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
