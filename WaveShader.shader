shader_type canvas_item;

uniform float time_factor = 1.0;
uniform vec2 amplitude = vec2(10.0, 5.0);
uniform vec2 tiled_factor = vec2(5.0, 5.0);
uniform float aspect_ratio = 0.5;

uniform vec2 offset_scale = vec2(0.1, 0.1);

//void vertex() {
//	VERTEX.x += cos(TIME * time_factor + VERTEX.x) * amplitude.x;
//	VERTEX.y += sin(TIME * time_factor + VERTEX.y) * amplitude.y;
//}

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	tiled_uvs.y *= aspect_ratio;
	
	vec2 uv_offset;
	uv_offset.x = (cos(TIME + tiled_uvs.x + tiled_uvs.y) * offset_scale.x) * -1.0;
	uv_offset.y = (sin(TIME * time_factor + tiled_uvs.x + tiled_uvs.y) * offset_scale.y) * -1.0;
	
//	COLOR = vec4(tiled_uvs, 0.0, 1.0);
	COLOR = texture( TEXTURE, tiled_uvs + uv_offset * tiled_uvs * amplitude);
} 
