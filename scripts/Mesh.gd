tool
extends MeshInstance2D

export (PoolVector2Array) var polygon: PoolVector2Array = []
export (float) var mesh_thickness := 3.0
export (Color) var gizmo_color := Color.white

var VectorGraphics := preload("res://scripts/VectorGraphics.gd")
  
func _process(_delta: float):
  if Engine.editor_hint:
    update()
  
func _draw():
  if Engine.editor_hint and polygon.size() > 0:
    draw_colored_polygon(polygon, gizmo_color)

func create_mesh_from_points(points: PoolVector2Array) -> void:
  mesh = VectorGraphics.make_2d_polygon_mesh(points, mesh_thickness)
  mesh.surface_set_name(0, "surface")
    
func create_mesh() -> void:
  create_mesh_from_points(polygon)