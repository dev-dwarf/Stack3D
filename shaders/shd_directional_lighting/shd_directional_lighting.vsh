attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2  v_vTexcoord;
varying vec4  v_vColour;
varying float v_vIllumination;
varying float v_vLightDepth;
varying vec2  v_vLightMapPosition;

uniform vec3  u_LightForward;
uniform vec3  u_LightRight;
uniform vec3  u_LightUp;
uniform vec3  u_LightPosition;
uniform float u_LightSize;
uniform float u_LightLenght;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	vec4 world_space_pos  = gm_Matrices[MATRIX_WORLD] * object_space_pos;
	vec3 world_space_norm = normalize(mat3(gm_Matrices[MATRIX_WORLD]) * in_Normal);
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	float illumination    = -dot(world_space_norm, u_LightForward);
	vec3  light_to_object = vec3(world_space_pos) - u_LightPosition;
	float light_depth     = dot(light_to_object, u_LightForward);
	float light_depth_01  = clamp(light_depth / u_LightLenght, 0.0, 1.0);
	float light_map_U     = 0.5 + dot(light_to_object, u_LightRight) / u_LightSize;
	float light_map_V     = 0.5 - dot(light_to_object, u_LightUp )   / u_LightSize;
	
    v_vColour           = in_Colour;
    v_vTexcoord         = in_TextureCoord;
	v_vIllumination     = illumination;
	v_vLightDepth       = light_depth_01;
	v_vLightMapPosition = vec2(light_map_U, light_map_V);
}
