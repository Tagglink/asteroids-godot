shader_type canvas_item;

void fragment() {
	vec3 col = texture(TEXTURE, SCREEN_UV).xyz;
	
    col += texture(TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, 0.0)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, 0.0)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(2.0 * SCREEN_PIXEL_SIZE.x, 0.0)).xyz * 0.04;
    col += texture(TEXTURE, SCREEN_UV + vec2(2.0 * -SCREEN_PIXEL_SIZE.x, 0.0)).xyz * 0.04;
	
    col += texture(TEXTURE, SCREEN_UV + vec2(0.0, SCREEN_PIXEL_SIZE.y)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(0.0, -SCREEN_PIXEL_SIZE.y)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(0.0, 2.0 * SCREEN_PIXEL_SIZE.y)).xyz * 0.04;
    col += texture(TEXTURE, SCREEN_UV + vec2(0.0, 2.0 * -SCREEN_PIXEL_SIZE.y)).xyz * 0.04;
	
    col += texture(TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(2.0 * SCREEN_PIXEL_SIZE.x, 2.0 * SCREEN_PIXEL_SIZE.y)).xyz * 0.04;
    col += texture(TEXTURE, SCREEN_UV + vec2(2.0 * -SCREEN_PIXEL_SIZE.x, 2.0 * -SCREEN_PIXEL_SIZE.y)).xyz * 0.04;
	
    col += texture(TEXTURE, SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x, -SCREEN_PIXEL_SIZE.y)).xyz * 0.07;
    col += texture(TEXTURE, SCREEN_UV + vec2(2.0 * -SCREEN_PIXEL_SIZE.x, 2.0 * SCREEN_PIXEL_SIZE.y)).xyz * 0.04;
    col += texture(TEXTURE, SCREEN_UV + vec2(2.0 * SCREEN_PIXEL_SIZE.x, 2.0 * -SCREEN_PIXEL_SIZE.y)).xyz * 0.04;
	
    COLOR.xyz = col;
}