//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

void main()
{
    vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (color.a == 0.0) discard;
	
	gl_FragColor = color;
}
