tool
extends RigidBody2D

signal destroyed
signal hit

export (float) var min_speed := 50.0
export (float) var max_speed := 200.0
export (float) var radius := 24.0 setget radius_set
export (int) var point_count := 12
export (float) var scramble_weight := 0.8
export (int) var hp = 1
export (ShaderMaterial) var mesh_material: ShaderMaterial

var VectorGraphics := preload("res://scripts/VectorGraphics.gd")

func _ready():
  if !Engine.editor_hint:
    $Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
    
    var shape_seed := rand_range(0.0, 1.0)
    var polygon: PoolVector2Array = VectorGraphics.jagged_circle_poly(
      radius, point_count, scramble_weight, shape_seed
      )
    $Mesh.create_mesh_from_points(polygon)
    
    if mesh_material != null:
      $Mesh.set_material(mesh_material)
  
func _on_Visibility_screen_exited():
  queue_free()
  
func radius_set(value: float):
  if (has_node("CollisionShape")):
    get_node("CollisionShape").shape.radius = value * 1.5
  radius = value

func on_hit() -> void:
  emit_signal("hit")
  hp -= 1
  if hp <= 0:
    destroy()
  
func destroy() -> void:
  emit_signal("destroyed")
  queue_free()