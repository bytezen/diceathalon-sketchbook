shader_type canvas_item;

uniform sampler2D pattern_sampler : repeat_enable, filter_linear_mipmap;
uniform vec3 bg_color : source_color;
uniform vec3 pattern_color : source_color;
uniform float pattern_size = 256.0;
uniform float speed_x = 0.05;
uniform float speed_y = 0.05;

void fragment() {
	vec2 uv = FRAGCOORD.xy / pattern_size;
	if(speed_x > 0.0) {
		uv.x += TIME * -1.0 * speed_x;
	}
	if(speed_y > 0.0){
		uv.y += TIME * speed_y;
	}
	
	//COLOR.rgb = mix(pattern_color, bg_color, texture(pattern_sampler, uv + TIME * 0.05).x);
	COLOR.rgb = mix(pattern_color, bg_color, texture(pattern_sampler, uv).x);
	
}
