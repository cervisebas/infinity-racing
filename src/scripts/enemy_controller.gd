extends Node2D

@onready
var spawn_points = $SpawnPoints.get_children()

# Game
@export
var running = true

# Scene speed
@export
var speedScene = 200

@export
var minSpeedScene = 200

@export
var maxSpeedScene = 5100

# Mob Timers Spawn
var minMobTimerSpawn = 0.5
var maxMobTimerSpawn = 5

# Spawn Patters
@onready
var markers = [
	$LeftMarker2D,
	$CenterMarker2D,
	$RightMarker2D
]

# Enemies
var Enemies = [
	preload("res://src/elements/car_enemy.tscn"),
]

var last_pattern = EnemySpawnPatterns.Patterns[0]

func _process(_delta: float) -> void:
	var mobTimerSpawn = float(maxSpeedScene) / float(speedScene)
	if (mobTimerSpawn < minMobTimerSpawn):
		mobTimerSpawn = minMobTimerSpawn
	elif (mobTimerSpawn > maxMobTimerSpawn):
		mobTimerSpawn = maxMobTimerSpawn
	
	if ($MobTimer.wait_time != mobTimerSpawn):
		$MobTimer.wait_time = mobTimerSpawn
	
	for enemy in $Enemies.get_children():
		enemy.speed = speedScene / 2.0


func clear_enemies():
	for enemy in $Enemies.get_children():
		$Enemies.remove_child(enemy)


func _on_mob_timer_timeout() -> void:
	if (!running):
		return
	
	var use_pattern = EnemySpawnPatterns.Patterns.pick_random()
	
	while (last_pattern == use_pattern):
		use_pattern = EnemySpawnPatterns.Patterns.pick_random()
	
	last_pattern = use_pattern
	
	for marker in use_pattern:
		var spawn_point = get_spawn_point(marker)
		
		if (spawn_point == null):
			continue
		
		var enemy: ObstacleStrategy = Enemies.pick_random().instantiate()
		enemy.set_position(spawn_point.position)
		enemy.set_speed(randi_range(100, 300))
		
		$Enemies.add_child(enemy)

func get_spawn_point(marker: EnemyPosition.P):
	match marker:
		EnemyPosition.P.CENT:
			return $SpawnPoints/CenterMarker2D

		EnemyPosition.P.LEFT:
			return $SpawnPoints/LeftMarker2D
			
		EnemyPosition.P.RIGH:
			return $SpawnPoints/RightMarker2D
	
	return null

func set_speeds(speed: float, minSpeed: float, maxSpeed: float):
	speedScene = speed
	minSpeedScene = minSpeed
	maxSpeedScene = maxSpeed
