extends Node

@onready var spawn_points = $SpawnPoints.get_children()

@onready var LM2D = $SpawnPoints/LeftMarker2D
@onready var CM2D = $SpawnPoints/CenterMarker2D
@onready var RM2D = $SpawnPoints/RightMarker2D

@export var mob_scene: PackedScene
var score

func _ready():
	print("start")

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
		
		add_child(enemy)
		
