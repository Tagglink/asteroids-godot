extends Node2D

var center_of_screen := Vector2(540, 300)

var VectorGraphics := preload("res://scripts/VectorGraphics.gd")

func _ready():
  $Line1.origin = center_of_screen
  $Line2.origin = center_of_screen
  $Line2.destination = center_of_screen + Vector2(50.0, 0.0)
  
  $Line1.color = Color.red
  $Line2.color = Color.pink

func _input(event):
  if event is InputEventMouseMotion:
    $Line1.destination = event.position
    
    var a : Vector2 = ($Line1.destination - $Line1.origin)
    var b : Vector2 = ($Line2.destination - $Line2.origin)
    
    var angle := VectorGraphics.angle_between(a, b, false)
    var angle2 := a.angle_to(b)
    
    $MyAngle.text = "angle_between: %f" % angle
    $GodotAngle.text = "angle_to: %f" % angle2