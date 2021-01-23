varying vec2  v_vTexcoord;
varying vec4  v_vColour;
varying float v_vIllumination;
varying float v_vLightDepth;
varying vec2  v_vLightMapPosition;

uniform sampler2D u_ShadowMap;

const float SCALE_FACTOR = 256.0 * 256.0 * 256.0 - 1.0;
const vec3 SCALE_VECTOR = vec3(1.0, 256.0, 256.0 * 256.0) / SCALE_FACTOR * 255.0;
float unpack8BitVec3IntoFloat(vec3 valRGB)
{
	return dot(valRGB, SCALE_VECTOR);
}

void main()
{
    vec3 packed_depth = texture2D(u_ShadowMap, v_vLightMapPosition).rgb;
	float depth = unpack8BitVec3IntoFloat(packed_depth);
	
	vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	if (color.a == 0.0) discard;
	gl_FragColor = color;
	
	//gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	if (v_vLightDepth > depth + 0.005)
	{
		gl_FragColor.rgb *= 0.3;
	}
	else
	{
		float smooth_illumination = smoothstep(0.1, 0.8, v_vIllumination);
		gl_FragColor.rgb *= mix(0.3, 1.0, smooth_illumination);
	}
}
