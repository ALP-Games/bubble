shader_type canvas_item;

uniform float effect_radius = 0.5;
uniform float effect_bluryness = 0.2;

uniform float white_thickness = 0.1;
uniform float white_bluryness = 0.1;

const vec2 screen_center = vec2(0.5);
const vec2 aspect = vec2(1., 2.);

float circle(vec2 uv, float radius, float bluryness) {
	vec2 dist = uv - (screen_center * aspect);
	return smoothstep(radius-(radius*bluryness),radius+(radius*bluryness),dot(dist,dist)*4.0);
}

void fragment() {
	vec2 uv = UV * aspect;
	float effect_circle = circle(uv, effect_radius, effect_bluryness);
	float min_effect_radius = max(0.0, effect_radius - white_thickness);
	float white_circle = circle(uv, min_effect_radius, white_bluryness);
	vec3 white_color = vec3(white_circle);
	vec3 black_color = vec3(effect_circle);
	vec3 result = white_color - black_color;
	COLOR = vec4(result, white_circle);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
