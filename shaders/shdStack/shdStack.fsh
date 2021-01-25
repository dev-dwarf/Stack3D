//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

void main()
{
	vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = color;
	
	if (color.a <= 0.1) discard;
	//float alpha_discard = float((color.a > 0.1));
	//gl_FragColor.a *= alpha_discard;
}
