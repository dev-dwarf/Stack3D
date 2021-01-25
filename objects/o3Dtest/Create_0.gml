/// @description init and load 3d models
show_debug_overlay(true);

shader_mode = 6;

// lower values will increase performance, but can make the background appear through models

// values equal or higher than 4 will use z-tilting when building the models,
// which can fill in gaps between the vertices
stacking_fidelity = 8;

// CREATE A FORMAT AND RETRIEVE THE TEXTURE FOR THE SPRITE STACKING TO USE
format = create_vertex_format();

textures = ds_map_create();
buffers = ds_map_create();

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