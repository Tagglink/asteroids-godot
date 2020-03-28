extends Control

onready var root_node: Viewport = get_tree().get_root()
onready var hud = $HUD
onready var world = find_node("World")

func _ready():
  root_node.connect("size_changed", self, "_on_root_size_changed")
  world.connect("score_changed", self, "_on_world_score_changed")
  update_size()
  
func _on_root_size_changed():
  update_size()
  
func _on_world_score_changed(new_value: int):
  hud.score = new_value

func update_size() -> void:
  rect_size = root_node.get_size()
