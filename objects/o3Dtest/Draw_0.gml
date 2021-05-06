/// @description draw 3d models

if !(surface_exists(drawing_surface)) drawing_surface = surface_create(oCamera.default_camera_height*drawing_surface_resolution, oCamera.default_camera_height*drawing_surface_resolution);

// make sure you draw the models using a shader
//   default is shdStack
switch shader_mode {
	default: case 0:
	shader_set(shdStack);
	break;
	case 1: // wobble
	shader_set(shdWobble);
	shader_set_uniform_f(wobble_time, current_time * 0.01);
	shader_set_uniform_f(wobble_intensity, 0.1);
	break;
	case 2: // phase
	shader_set(shdPhase);
	shader_set_uniform_f(phase_time, current_time * 0.01);
	break;
	case 3: // rainbow
	shader_set(shdRainbow);
	shader_set_uniform_f(rainbow_time, current_time * 0.01);
	break;
	case 4: // distort
	shader_set(shdDistort);
	shader_set_uniform_f(distort_time, current_time * 0.01);
	shader_set_uniform_f(distort_intensity, 0.01);
	break;
	case 5: // wave
	shader_set(shdWave);
	shader_set_uniform_f(wave_time, current_time * 0.01);
	shader_set_uniform_f(wave_intensity, 0.1);
	break;
}

//surface_set_target(drawing_surface);
draw_clear(c_black);
camera_apply(oCamera.camera);

with pDepth {
	draw_can_draw = true;
	event_perform(ev_draw, 0);
	draw_can_draw = false;
}
	
//surface_reset_target();
shader_reset();

// IMPORTANT! reset world matrix and shader for other drawing
matrix_set(matrix_world, matrix_build_identity());