extends Control

onready var root_node: Viewport = get_tree().get_root()

func _ready():
  root_node.connect("size_changed", self, "_on_root_size_changed")
  update_size()
  
func _on_root_size_changed():
  update_size()

func update_size() -> void:
  rect_size = root_node.get_size()