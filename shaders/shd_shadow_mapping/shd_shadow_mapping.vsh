attribute vec3 in_Position;

varying float v_vLightDepth;

uniform vec3  u_LightForward;
uniform vec3  u_LightPosition;
uniform float u_LightLenght;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
	vec4 world_space_pos  = gm_Matrices[MATRIX_WORLD] * object_space_pos;
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	vec3 light_to_object = vec3(world_space_pos) - u_LightPosition;
	float light_depth = dot(light_to_object, u_LightForward);
	float light_depth_01 = clamp(light_depth / u_LightLenght, 0.0, 1.0);

	v_vLightDepth = light_depth_01;
}
