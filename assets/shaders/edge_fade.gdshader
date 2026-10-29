
shader_type canvas_item;
render_mode blend_mix;

uniform float edge_width : hint_range(0.0, 0.5) = 0.35;
uniform float side_fade_start : hint_range(0.0, 0.5) = 0.15;
uniform float side_fade_strength : hint_range(0.0, 1.0) = 0.95;

// UV.y = 0 is the top; smaller values move the center upward.
uniform float fade_center_y : hint_range(0.0, 1.0) = 0.42;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Shift the vertical fade center slightly toward the top.
    float vertical_dist = min(
        UV.y / max(fade_center_y, 0.001),
        (1.0 - UV.y) / max(1.0 - fade_center_y, 0.001)
    );

    float vertical_alpha = smoothstep(
        0.0,
        edge_width,
        vertical_dist
    );

    // Symmetrical left and right fades.
    float fade_width = side_fade_start + edge_width;

    float left_fade = 1.0 - smoothstep(
        0.0, fade_width, UV.x
    );

    float right_fade = 1.0 - smoothstep(
        0.0, fade_width, 1.0 - UV.x
    );

    float side_fade = max(left_fade, right_fade);
    float side_alpha = 1.0 - side_fade_strength * side_fade;

    // Preserve the original texture colors.
    tex.a *= vertical_alpha * side_alpha;
    COLOR = vec4(tex.rgb, tex.a * COLOR.a);
}
