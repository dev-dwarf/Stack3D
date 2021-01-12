//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;

uniform float time;
uniform float intensity;

// GOLD NOISE FUNCTION: https://stackoverflow.com/questions/4200224/random-noise-functions-for-glsl
float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio   

float gold_noise(in vec2 xy, in float seed){
       return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos + intensity*vec4(gold_noise(in_Position.xy, time+in_Position.z), gold_noise(in_Position.xy, time+in_Position.z), 0.0, 0.0);
    
    v_vTexcoord = in_TextureCoord;
}
