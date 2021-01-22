//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec3 v_vPosition;

uniform float time;

void main()
{
	vec4 hue_shift = vec4(0.5 * (1.0 + cos(time*0.3 + v_vPosition.z*0.1)), 0.5 * (1.0 + sin(time*0.4 + v_vPosition.z*0.1)), 0.5 * (1.0 + cos(time*0.5 + v_vPosition.z*0.1)), 1.0);
	
	vec4 color = hue_shift * texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (color.a == 0.0) discard;
	
	gl_FragColor = color;
}
