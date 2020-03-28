extends Node2D

var GameConfig = preload("res://scripts/GameConfig.gd")

onready var root_node: Viewport = get_tree().get_root()

func _ready():
  root_node.connect("size_changed", self, "_on_root_size_changed")
  update_size()
  
func _on_root_size_changed():
  update_size()
  
func update_size() -> void:
  var size_vec = root_node.get_size()
  scale = size_vec / GameConfig.SCREEN_SIZE
