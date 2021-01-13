//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec3 v_vPosition;


uniform float time;

void main()
{
	float alpha = abs(cos(time * 0.628));
	vec4 color  = texture2D( gm_BaseTexture, v_vTexcoord );
	
	color.a *= alpha;
	
    gl_FragColor = color;
}
