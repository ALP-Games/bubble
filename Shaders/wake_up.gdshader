shader_type canvas_item;

uniform float radius = 0.5;
uniform float bluryness = 0.5;

const vec2 screen_center = vec2(0.5);

void fragment() {
	vec2 dist = UV - screen_center;
	float circle = smoothstep(radius-(radius*bluryness),radius+(radius*bluryness),dot(dist,dist)*4.0);
	COLOR = vec4(0.0, 0.0, 0.0, circle);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
