extends Node2D

var VectorGraphics := preload("res://scripts/VectorGraphics.gd")

onready var mesh: MeshInstance2D = $Mesh
onready var seed_slider: HSlider = $UI/SeedSlider
onready var radius_slider: HSlider = $UI/Params/Radius
onready var points_slider: HSlider = $UI/Params/Points
onready var scramble_slider: HSlider = $UI/Params/Scramble

onready var seed_label: Label = $UI/SeedLabel
onready var radius_label: Label = $UI/Params/RadiusLabel
onready var points_label: Label = $UI/Params/PointsLabel
onready var scramble_label: Label = $UI/Params/ScrambleLabel

func _ready():
  var screen_size: Vector2 = get_tree().get_root().get_size()
  mesh.position = screen_size * 0.5
  
  seed_slider.connect("value_changed", self, "_on_seed_slider_value_changed")
  radius_slider.connect("value_changed", self, "_on_radius_slider_value_changed")
  points_slider.connect("value_changed", self, "_on_points_slider_value_changed")
  scramble_slider.connect("value_changed", self, "_on_scramble_slider_value_changed")
  
  seed_slider.value = 0.0
  radius_slider.value = 30
  points_slider.value = 8
  scramble_slider.value = 0.5
  
  regenerate()
  
func regenerate():
  generate(radius_slider.value, points_slider.value, scramble_slider.value, seed_slider.value)

func generate(radius: float, point_count: int, scramble_weight: float, shape_seed: float):
  var polygon: PoolVector2Array = VectorGraphics.jagged_circle_poly(
    radius, point_count, scramble_weight, shape_seed
    )
  
  $Mesh.create_mesh_from_points(polygon)
  
func _on_seed_slider_value_changed(value: float):
  seed_label.text = "Seed: %f" % value
  regenerate()
  
func _on_radius_slider_value_changed(value: float):
  radius_label.text = "Radius: %f" % value
  regenerate()

func _on_points_slider_value_changed(value: float):
  points_label.text = "Points: %d" % value
  regenerate()
  
func _on_scramble_slider_value_changed(value: float):
  scramble_label.text = "Scramble: %f" % value
  regenerate()