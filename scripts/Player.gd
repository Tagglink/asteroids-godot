extends RigidBody2D

export (float) var acceleration := 200.0
export (float) var rotational_speed := 100.0
export (float) var bullet_speed := 100.0

export (PackedScene) var bullet_scene: PackedScene
export (ShaderMaterial) var mesh_material: ShaderMaterial

signal hit

var smoothing := 0.0

func _ready():
  set_contact_monitor(true)
  set_max_contacts_reported(4)
  
  connect("body_entered", self, "_on_Player_body_entered")
  
  $Mesh.create_mesh()
  
  if mesh_material != null:
    $Mesh.set_material(mesh_material)
    
  var screen_size: Vector2 = get_tree().get_root().get_size()
  
  position = screen_size * 0.5
  
func _process(_delta: float):
  if Input.is_action_just_pressed("shoot"):
    shoot()
    
  if Input.is_action_just_pressed("ui_down"):
    smoothing -= 0.1
    if smoothing < 0.0: 
      smoothing = 0.0
    material.set_shader_param("smoothing", smoothing)
  if Input.is_action_just_pressed("ui_up"):
    smoothing += 0.1
    if smoothing > 1.0:
      smoothing = 1.0
    material.set_shader_param("smoothing", smoothing)
  
func _physics_process(delta: float):
  var movement := get_movement() * delta
  
  var accel_direction := Vector2.DOWN.rotated(rotation)
  linear_velocity += accel_direction * movement.y * acceleration
  
  if movement.y > 0.0:
    $ThrusterEmitter.rotation_degrees = 270
    $ThrusterEmitter.emitting = true
  elif movement.y < 0.0:
    $ThrusterEmitter.rotation_degrees = 90
    $ThrusterEmitter.emitting = true
  else:
    $ThrusterEmitter.emitting = false
  
  angular_velocity = movement.x * rotational_speed

func get_movement() -> Vector2:
  var input := Vector2.ZERO
  
  if Input.is_action_pressed("up"):
    input.y -= 1
  if Input.is_action_pressed("right"):
    input.x += 1
  if Input.is_action_pressed("down"):
    input.y += 1
  if Input.is_action_pressed("left"):
    input.x -= 1
	
  return input
  
func shoot() -> void:
  var bullet = bullet_scene.instance()
  find_parent("World").add_child(bullet)
  
  var bullet_direction := Vector2.UP.rotated(rotation)
  bullet.velocity = bullet_direction * bullet_speed
  
  # Bullets get velocity relative to the ship
  bullet.velocity += linear_velocity
  
  bullet.position = $BulletOrigin.global_position
  bullet.rotation = rotation
  
func _on_Player_body_entered(_body: Node) -> void:
  hide()
  emit_signal("hit")
  
