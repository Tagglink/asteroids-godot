extends Area2D

# Usage: Instance the bullet and then set its velocity and position
var velocity := Vector2.ZERO

func _ready():
  $Visibility.connect("screen_exited", self, "_on_VisibilityNotifier2D_screen_exited")
  connect("body_entered", self, "_on_Bullet_body_entered")
  $Mesh.create_mesh()
  
func _physics_process(delta: float):
  position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
  queue_free()
  
func _on_Bullet_body_entered(body: PhysicsBody2D):
  body.on_hit() # duck