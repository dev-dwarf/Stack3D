//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;

uniform float time;
uniform float intensity;

void main()
{
	vec3 new_position = vec3((1.0+intensity*cos(time+in_TextureCoord.x+in_Position.x*100.0)),(1.0+intensity*cos(time+in_TextureCoord.x+in_Position.x*100.0)),1.0)*in_Position;
	
    vec4 object_space_pos = vec4( new_position.x, new_position.y, new_position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vTexcoord = in_TextureCoord;
}
