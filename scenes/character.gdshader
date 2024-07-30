shader_type canvas_item;

uniform vec4 ghost_color = vec4(1.0, 1.0, 1.0, 0.5);
uniform float ghost_strength : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
    vec4 color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
    vec4 ghost = texture(SCREEN_TEXTURE, SCREEN_UV);
    color = mix(color, ghost_color * ghost, ghost_strength);
    COLOR = color;
}



//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
