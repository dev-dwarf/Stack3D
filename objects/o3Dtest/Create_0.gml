/// @description init and load 3d models
show_debug_overlay(true);

shader_mode = 6;

// lower values will increase performance, but can make the background appear through models

// use values of 4 or less
stacking_fidelity = 16;

// FUNCTION FOR DEPTH SORTING
function compute_3d_depth() {

	var _x				= argument[0];
	var _y				= argument[1];
	var _z				= argument[2];

	var _depth = _x * dcos(90 + oCamera.camera_angle) +
				 _y * dsin(90 + oCamera.camera_angle) +
				 _z;

	return -1 * _depth;


}

// CREATE A FORMAT AND RETRIEVE THE TEXTURE FOR THE SPRITE STACKING TO USE
format = create_vertex_format();

textures = ds_map_create();
buffers = ds_map_create();

function load_sprite(sprite_index, layer_count) {
	if (is_undefined(buffers[? sprite_index])) {
		textures[? sprite_index] = sprite_get_texture(sprite_index, 0);

		// USE THE FUNCTIONS TO LOAD THE MODEL
		buffers[? sprite_index] = load_stack_sprite(sprite_index, layer_count, format, stacking_fidelity);

		// FREEZE THE MODEL (optional)
		vertex_freeze(buffers[? sprite_index]); // makes the buffer read only, but increases performance significantly.
	}
}


#region shader uniforms
wobble_time			= shader_get_uniform(shdWobble, "time");
wobble_intensity	= shader_get_uniform(shdWobble, "intensity");

phase_time			= shader_get_uniform(shdPhase, "time");

rainbow_time		= shader_get_uniform(shdRainbow, "time");

distort_time		= shader_get_uniform(shdDistort, "time");
distort_intensity	= shader_get_uniform(shdDistort, "intensity");

wave_time			= shader_get_uniform(shdWave, "time");
wave_intensity		= shader_get_uniform(shdWave, "intensity");

#endregion