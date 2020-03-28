extends Node

class_name VectorGraphics

# Input parameter 1 is an array of Vector2s making up a polygon
# Input parameter 2 is the thickness of the resulting ArrayMesh
# Return value is an ArrayMesh
static func make_2d_polygon_mesh(points: Array, thickness: float) -> ArrayMesh:
  var vertices := PoolVector2Array()
  var indices := PoolIntArray()
  var uvs := PoolVector2Array()
  var arrays := []
  arrays.resize(ArrayMesh.ARRAY_MAX)
  
  for i in range(points.size()):
    # in the polygon, get current, previous and next point
    var current: Vector2 = points[i]
    
    var previous: Vector2
    if i == 0:
      previous = points[points.size() - 1]
    else:
      previous = points[i - 1]
      
    var next: Vector2 = points[(i + 1) % points.size()]
    
    # get the angle between the vectors to the previous and next points
    var vec_prev := previous - current
    var vec_next := next - current
    
    var angle := vec_prev.angle_to(vec_next)
    if angle < 0.0:
      angle += 2 * PI
    
    # rotate one of the vectors halfway around that angle
    var vec_offset := vec_prev.rotated(angle * 0.5)
    # make it half of 'thickness' long
    vec_offset = vec_offset.normalized() * thickness * 0.5
    
    # create two new vertices on each side of the polygon point
    vertices.push_back(current + vec_offset)
    vertices.push_back(current - vec_offset)
    
    uvs.push_back(Vector2(float(i * 2) / points.size(), 1.0))
    uvs.push_back(Vector2(float(i * 2 + 1) / points.size(), 0.0))
    
    # triangulate towards the next two points
    var tri_a := [
      i * 2, 
      (i * 2 + 1) % (points.size() * 2), 
      (i * 2 + 2) % (points.size() * 2)
    ]
    
    var tri_b := [
      (i * 2 + 1) % (points.size() * 2),
      (i * 2 + 3) % (points.size() * 2),
      (i * 2 + 2) % (points.size() * 2)
    ]
    
    indices.append_array(tri_a)
    indices.append_array(tri_b)
  
  arrays[ArrayMesh.ARRAY_VERTEX] = vertices
  arrays[ArrayMesh.ARRAY_INDEX] = indices
  arrays[ArrayMesh.ARRAY_TEX_UV] = uvs
  
  var arr_mesh := ArrayMesh.new()
  arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
  
  return arr_mesh
  
static func jagged_circle_poly(
  radius: float,
  point_count: int,
  scramble_weight: float,
  shape_seed: float
  ) -> PoolVector2Array:
  var poly := PoolVector2Array()
  
  for i in range(point_count):
    var angle := (i + shape_seed) * PI * 2.0 / point_count
    var offset := 1.0 + scramble(shape_seed * i) * scramble_weight
    var point := Vector2(cos(angle), sin(angle))
    point *= offset
    point *= radius
    
    poly.push_back(point)
    
  return poly
  
static func make_2d_line_mesh(points: Array):
  var vertices := PoolVector2Array()
  var arrays := []
  arrays.resize(ArrayMesh.ARRAY_MAX)
  
  for i in range(points.size()):
    # in the polygon, get current, previous and next point
    var current: Vector2 = points[i]
    
    vertices.push_back(current)
  
  arrays[ArrayMesh.ARRAY_VERTEX] = vertices
  
  var arr_mesh := ArrayMesh.new()
  arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_LOOP, arrays)
  
  return arr_mesh

# produces a number in the range -0.5 < x < 0.5 from a constant
static func scramble(s: float) -> float:
  var p := 400
  var q := 3
  return (fmod(s * p, q) - q / 2.0) / q

static func angle_between(a: Vector2, b: Vector2, clockwise: bool) -> float:
  var a_len := a.length()
  var b_len := b.length()
  var c_len_sqr := (a - b).length_squared()
  
  var x := (a_len * a_len) + (b_len * b_len) - c_len_sqr
  var d := 2 * a_len * b_len
  
  return acos(x / d)