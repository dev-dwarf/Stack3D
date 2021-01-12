/// @description init and load 3d models
show_debug_overlay(true);
depth_grid = -1;

shader_mode = 6;

// lower values will increase performance, but can make the background appear through models
stacking_fidelity = 4;

// SPAWN INSTANCES FOR A STRESS TEST
repeat(2000) {
	with instance_create_layer(irandom(room_width*2)*choose(-1,1), irandom(room_width*2)*choose(-1,1), layer, oCup) {
		image_angle = irandom(360);
	}
}

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
texture = sprite_get_texture(sprite_index, 0);

// USE THE FUNCTIONS TO LOAD THE MODEL
vertex_buffer = load_stacked_sprite(sprite_index, texture, sprite_height/sprite_width, format, stacking_fidelity);

// FREEZE THE MODEL (optional)
vertex_freeze(vertex_buffer); // makes the buffer read only, but increases performance significantly.


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