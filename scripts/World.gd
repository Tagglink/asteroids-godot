extends Node2D

signal score_changed(new_value)

export (PackedScene) var asteroid_scene: PackedScene

var GameConfig = preload("res://scripts/GameConfig.gd")

onready var root_node: Viewport = get_tree().get_root()

var score := 0 setget set_score

func _ready():
  randomize()
  
  $Player.connect("hit", self, "_on_Player_hit")
  $AsteroidTimer.connect("timeout", self, "_on_AsteroidTimer_timeout")
  
  $AsteroidTimer.start()
  
func game_over() -> void:
  get_tree().reload_current_scene()
  
func _on_AsteroidTimer_timeout():
  $AsteroidPath/AsteroidLocation.set_offset(randi())
  
  var asteroid = asteroid_scene.instance()
  add_child(asteroid)
  
  var direction: float = $AsteroidPath/AsteroidLocation.rotation + PI / 2
  
  asteroid.position = $AsteroidPath/AsteroidLocation.position
  
  # figure out the ratio between the base screen size and the actual viewport size
  # to make sure the asteroid gets placed outside of the screen
  var position_scale = root_node.get_size() / GameConfig.SCREEN_SIZE
  asteroid.position *= position_scale
  
  direction += rand_range(-PI / 4, PI / 4)
  
  asteroid.rotation = direction
  
  asteroid.linear_velocity = Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
  asteroid.linear_velocity = asteroid.linear_velocity.rotated(direction)
  
  asteroid.connect("destroyed", self, "_on_Asteroid_destroyed")

func _on_Player_hit():
  game_over()
  
func _on_Asteroid_destroyed():
  set_score(score + 1)

func set_score(value: int) -> void:
  emit_signal("score_changed", value)
  score = value
