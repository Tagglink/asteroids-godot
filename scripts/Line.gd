extends Node2D

export (float) var line_thickness := 3.0

var origin := Vector2.ZERO
var destination := Vector2(1.0, 0.0)
var color := Color.red
  
func _process(_delta: float):
  update()
  
func _draw():
  draw_line(origin, destination, color, line_thickness)